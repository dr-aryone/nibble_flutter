import 'package:flutter/material.dart';

class ArticleBar extends StatelessWidget {
  final String reducedPercentage;

  ArticleBar({this.reducedPercentage});

  @override
  Widget build(BuildContext context) {
    if (reducedPercentage != "") {
      return new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Chip(
            label: new Text(
              "$reducedPercentage reduced",
              style: new TextStyle(
                color: Colors.white,
              ),
            ),
            // backgroundColor: Theme.of(context).primaryColor,
            backgroundColor:
                reducedPercentage == null ? Colors.transparent : Colors.green,
          ),
          new IconButton(
            icon: new Icon(Icons.thumb_up),
            color: Colors.grey,
            // color: buttonSelected == true
            //     ? Colors.grey
            //     : Theme.of(context).primaryColor,
            onPressed: () {
              // this.setState(() {
              //   buttonSelected = !buttonSelected;
              // });
            },
          ),
          new IconButton(
            icon: new Icon(Icons.thumb_down),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              // this.setState(() {
              //   buttonSelected = !buttonSelected;
              // });
            },
          ),
        ],
      );
    } else {
      return new Container();
    }
  }
}
