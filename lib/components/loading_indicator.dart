import 'package:flutter/material.dart';


class LoadingIndicator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(20.0),
      child: new Center(
        child: new CircularProgressIndicator(),
      ),
    );
  }

}