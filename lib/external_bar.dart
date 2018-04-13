import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ExternalBar extends StatelessWidget {
  final String url;
  final String source;

  ExternalBar({this.url, this.source});

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new FlatButton.icon(
          icon: new Icon(Icons.expand_more),
          label: new Text("Give me the full byte"),
          onPressed: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new WebviewScaffold(
                      url: url,
                      appBar: new AppBar(
                        title: new Text(source),
                      ),
                    ),
              ),
            );
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
