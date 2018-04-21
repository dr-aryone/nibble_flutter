import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

import 'dart:convert';

import './components/loading_indicator.dart';

import './models/article.dart';
import './article_page.dart';
import './key.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  ScrollController scrollController = new ScrollController();
  List<Article> articles;

  bool loading = false;
  bool refreshing = false;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    getArticles();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  Future<Null> getArticles() async {
    List<Article> fetchedArticles = new List();

    final String url = 'https://newsapi.org/v2/everything?';
    final String key = keys['news_api'];
    final String sources =
        "ars-technica,crypto-coin-news,engadget,hacker-news,techcrunch,techradar,the-next-web,the-verge,wired";
    final String language = "en";
    final int pageSize = 20;

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

    data['articles'].forEach((article) => fetchedArticles.add(Article.fromMap(article)));

    if (!mounted) {
      return;
    } else {
      this.setState(() {
        articles = this.articles == null || this.refreshing == true
            ? fetchedArticles
            : new List<Article>.from(this.articles..addAll(fetchedArticles));
        loading = false;
        refreshing = false;
      });
    }
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
      itemCount: articles == null ? 0 : articles.length + 1,
      itemBuilder: (context, index) {
        if (index == articles.length) {
          return LoadingIndicator(loading: loading);
        } else {
          return buildList(context, index);
        }
      },
    );

    return new RefreshIndicator(
      onRefresh: handleRefresh,
      child: listView,
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

  String getTimeString(String publishedAt) {
    final Duration difference =
        new DateTime.now().difference(DateTime.parse(publishedAt));
    final int days = difference.inDays;
    final int hours = difference.inHours;
    final int minutes = difference.inMinutes;

    if (days > 0) {
      return "$days days ago";
    } else if (hours > 0) {
      return "$hours hours ago";
    } else {
      return "$minutes minutes ago";
    }
  }

  Widget buildList(BuildContext context, int index) {
    var articlePublishedTime = getTimeString(articles[index].publishedAt);

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
                          imageUrl: articles[index].urlToImage == null
                              ? 'http://shashgrewal.com/wp-content/uploads/2015/05/default-placeholder.png'
                              : articles[index].urlToImage,
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
                          articles[index].title,
                          style: Theme.of(context).textTheme.subhead,
                          textAlign: TextAlign.left,
                          maxLines: 3,
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                        child: new Text(
                          articles[index].source['name'],
                          style:
                              new TextStyle(fontSize: 12.0, color: Colors.grey),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      new Text(
                        articlePublishedTime,
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
