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
        new Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: new Icon(
            Icons.check_circle,
            size: 60.0,
            color: Colors.green,
          ),
        ),
        new Text(
          "You're all caught up. Start browsing!",
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
      ],
    );
  }
}

