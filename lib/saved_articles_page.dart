import 'package:flutter/material.dart';

class SavedArticlesPage extends StatefulWidget {
  @override
  SavedArticlesPageState createState() => new SavedArticlesPageState();
}

class SavedArticlesPageState extends State<SavedArticlesPage> {

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Container(
            height: 100.0,
            child: new Image.asset('assets/loading.gif',)
          ),
        ),
        new Text("Sorry you don't have any articles saved yet!"),
      ],
    );
  }
}

