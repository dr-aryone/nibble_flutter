import 'dart:core';

class Nibble {

  final String message;
  final String characterCount;
  final String contentReduced;
  final String title;
  final String content;
  final String limitation;

  Nibble({this.message, this.characterCount, this.contentReduced, this.title, this.content, this.limitation});

  Nibble.fromMap(Map json) : 
    message = json['sm_api_message'],
    characterCount = json['sm_api_character_count'],
    contentReduced = json['sm_api_content_reduced'],
    title = json['sm_api_title'],
    content = json['sm_api_content'],
    limitation = json['sm_api_limitation'];
}