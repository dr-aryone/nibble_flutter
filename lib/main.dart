import 'package:flutter/material.dart';

import './home_page.dart';
import './saved_articles_page.dart';
import './profile_page.dart';

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
        indicatorColor: Colors.white,
      ),
      // home: new HomePage(),
      home: new DefaultTabController(
      length: 3,
      child: new Scaffold(
          appBar: new AppBar(
            title: new Text("Nibble"),
            bottom: new TabBar(
              tabs: [
                new Tab(icon: new Icon(Icons.format_list_bulleted)),
                new Tab(icon: new Icon(Icons.bookmark_border)),
                new Tab(icon: new Icon(Icons.account_circle)),
              ],
            ),
          ),
          body: new TabBarView(
            children: <Widget>[
              new HomePage(), 
              new SavedArticlesPage(),
              new ProfilePage(),
            ],
          )
      ),
    )
      // routes: <String, WidgetBuilder>{
      //   "/article": (BuildContext context) => new Article(),
      // }
    );
  }
}
