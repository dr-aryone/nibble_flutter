import 'dart:core';

class Article {

  final Map source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;

  Article({this.source, this.author, this.title, this.description, this.url, this.urlToImage, this.publishedAt});

  Article.fromMap(Map json) : 
    source = json['source'] ?? "Unknown",
    author = json['author'] ?? "Unknown",
    title = json['title'] ?? "Untitled",
    description = json['description'],
    url = json['url'],
    urlToImage = json['urlToImage'] ?? 'http://shashgrewal.com/wp-content/uploads/2015/05/default-placeholder.png',
    publishedAt = json['publishedAt'];
}