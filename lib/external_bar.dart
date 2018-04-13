import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ExternalBar extends StatelessWidget {

  final String url;

  ExternalBar ({this.url});

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new FlatButton.icon(
          icon: new Icon(Icons.expand_more),
          label: new Text("Give me the full byte"),
          onPressed: () {
            print("Navigate to new webview");
          },
        ),
        new IconButton(
          icon: new Icon(Icons.share),
          onPressed: () {
            share("Check out this article I read on the new Nibble app! $url");
          },
        ),
      ],
    );
  }
}