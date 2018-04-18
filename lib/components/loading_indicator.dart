import 'package:flutter/material.dart';


class LoadingIndicator extends StatelessWidget {

  final bool loading;

  LoadingIndicator({this.loading});

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: loading ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

}