import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'dart:convert';

import './article_page.dart';
import './key.dart';

void main() {
  MaterialPageRoute.debugEnableFadingRoutes =
      true; // ignore: deprecated_member_use
  runApp(new Nibble());
}

class Nibble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Nibble',
      theme: new ThemeData(
        // brightness: Brightness.dark,
        primaryColor: Colors.red,
      ),
      home: new HomePage(),
      // routes: <String, WidgetBuilder>{
      //   "/article": (BuildContext context) => new Article(),
      // }
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  ScrollController scrollController = new ScrollController();
  bool loading = false;
  bool refreshing = false;
  int currentPage = 1;

  launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    getArticles();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List articles;

  Future<Null> getArticles() async {
    var url = 'https://newsapi.org/v2/everything?';
    var key = keys['news_api'];
    var sources =
        "ars-technica,crypto-coin-news,engadget,hacker-news,techcrunch,techradar,the-next-web,the-verge,wired";
    var language = "en";
    var pageSize = 20;

    print("Retrieve Article");
    var response = await http.get(
      url +
          "sources=" +
          sources +
          '&language=' +
          language +
          '&pageSize=$pageSize' +
          '&page=$currentPage',
      headers: {
        "Authorization": key,
      },
    );

    var data = json.decode(response.body);

    List fetchedArticles = data['articles'];

    this.setState(() {
      articles = this.articles == null || this.refreshing == true
          ? fetchedArticles
          : new List.from(this.articles..addAll(fetchedArticles));
      loading = false;
      refreshing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final startLoadingOffset = 80.0;

    scrollController.addListener(() {
      if ((scrollController.position.maxScrollExtent - scrollController.offset <
              startLoadingOffset) &&
          (loading == false)) {
        this.setState(() {
          loading = true;
          currentPage += 1;
        });

        getArticles();
      }
    });

    ListView listView = new ListView.builder(
      controller: scrollController,
      itemCount: articles == null ? 0 : articles.length,
      itemBuilder: buildList,
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Nibble"),
      ),
      body: new RefreshIndicator(
        onRefresh: handleRefresh,
        child: listView,
      ),
    );
  }

  Future<Null> handleRefresh() async {
    this.setState(() {
      articles = [];
      currentPage = 1;
      refreshing = true;
    });

    return getArticles();
  }

  Widget buildList(BuildContext context, int index) {

    var articlePublishedTime = DateTime
        .parse(articles[index]['publishedAt'])
        .difference(new DateTime.now())
        .inMinutes
        .abs();

    return new InkWell(
      onTap: () {
        // launchURL(articles[index]['url']);
        // Navigator.of(context).pushNamed('/article');
        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) =>
                new ArticlePage(article: articles[index], index: index),
          ),
        );
      },
      child: Column(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(15.0),
            child: new Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Container(
                    width: 150.0,
                    child: new ClipRRect(
                      borderRadius: new BorderRadius.circular(8.0),
                      child: new Hero(
                        tag: 'articleImageTag$index',
                        child: new CachedNetworkImage(
                          // placeholder: new CircularProgressIndicator(),
                          imageUrl: articles[index]['urlToImage'] == null
                              ? 'http://shashgrewal.com/wp-content/uploads/2015/05/default-placeholder.png'
                              : articles[index]['urlToImage'],
                          height: 80.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Hero(
                        tag: 'articleTitle$index',
                        child: new Text(
                          articles[index]['title'],
                          style: Theme.of(context).textTheme.subhead,
                          textAlign: TextAlign.left,
                          maxLines: 3,
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                        child: new Text(
                          articles[index]['source']['name'],
                          style:
                              new TextStyle(fontSize: 12.0, color: Colors.grey),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      new Text(
                        articlePublishedTime.toString() + ' minutes ago',
                        style: new TextStyle(fontSize: 9.0, color: Colors.grey),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          new Divider()
        ],
      ),
    );
  }
}
