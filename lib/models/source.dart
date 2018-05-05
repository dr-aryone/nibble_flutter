import 'dart:core';

class Source {
  final String id;
  final String name;

  Source({this.id, this.name});

  Source.fromMap(Map json)
      : id = json['id'],
        name = json['name'];

}