import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/scheduler.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import './external_bar.dart';
import './article_bar.dart';
import './key.dart';

class ArticlePage extends StatefulWidget {
  final Map article;
  final int index;

  ArticlePage({this.article, this.index});

  @override
  ArticlePageState createState() => new ArticlePageState();
}

class ArticlePageState extends State<ArticlePage> {
  Map nibble;

  @override
  void initState() {
    super.initState();
    getNibble();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getNibble() async {
    print("Getting Nibble");
    String key = keys['smmry_api'];
    String url = widget.article['url'];
    int length = 8;

    String endpoint = 'http://api.smmry.com/';

    var response = await http.get(
      endpoint +
          "&SM_API_KEY=$key" +
          '&SM_LENGTH=$length' +
          '&SM_WITH_BREAK=true' +
          '&SM_URL=$url',
    );

    var data = json.decode(response.body);

    print(data);

    var formattedNibble =
        data['sm_api_content'].replaceAll(RegExp(r"(\[BREAK\])"), "\n\n");

    data['sm_api_content'] = formattedNibble;

    if (!mounted) {
      return;
    } else {
      this.setState(() {
        nibble = data;
      });
    }
  }

  launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // This is a hack to make it slow. Find a way to make Hero transition slower
    timeDilation = 2.0;

    return new Scaffold(
      appBar: new AppBar(title: Text("Nibble")),
      body: ListView(
        children: <Widget>[
          new InkWell(
            onTap: () {
              // selectedBrowser == 'external' ?  :
              // launchURL(widget.article['url']);
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new WebviewScaffold(
                        url: widget.article['url'],
                        appBar: new AppBar(
                          title: new Text(widget.article['source']['name']),
                        ),
                      ),
                ),
              );
            },
            child: new Hero(
              tag: 'articleImageTag${widget.index}',
              child: new ClipPath(
                clipper: new ArticleHeaderClipper(),
                child: new CachedNetworkImage(
                  height: 200.0,
                  imageUrl: widget.article['urlToImage'] == null
                      ? 'http://shashgrewal.com/wp-content/uploads/2015/05/default-placeholder.png'
                      : widget.article['urlToImage'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text(
              widget.article['title'],
              style: Theme.of(context).textTheme.title,
              textAlign: TextAlign.center,
            ),
          ),
          new Divider(),
          new ArticleBar(
              reducedPercentage:
                  nibble == null ? "" : nibble['sm_api_content_reduced']),
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text(
              nibble == null ? "" : nibble['sm_api_content'],
              style: Theme.of(context).textTheme.body1,
            ),
          ),
          new ExternalBar(
              url: widget.article['url'],
              source: widget.article['source']['name']),
        ],
      ),
    );
  }
}

class ArticleHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height / 1.3);
    path.lineTo(size.width, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
