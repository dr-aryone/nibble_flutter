import 'package:flutter/material.dart';
import '../configs/sources.dart';
import '../models/source.dart';

class SourcePage extends StatefulWidget {
  SourcePageState createState() => new SourcePageState();
}

class SourcePageState extends State<SourcePage> {
  final List<Source> selectedSources = <Source>[];

  final List<Source> sources = listOfSources;

  Iterable<Widget> get sourcesWidget sync* {
    for (Source source in sources) {
      yield new Padding(
        padding: const EdgeInsets.all(4.0),
        child: new FilterChip(
          label: new Text(source.name),
          tooltip: "Tap to select sources",
          selected: selectedSources.contains(source),
          selectedColor: Colors.lightGreen,
          onSelected: (bool value) {
            print(source.id);
            setState(() {
              if (value) {
                selectedSources.add(source);
              } else {
                selectedSources.removeWhere((Source selectedSource) {
                  return selectedSource == source;
                });
              }
            });
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new Image.asset('assets/planets.jpg'),
        new Expanded(
          child: new Center(
            child: new Container(
              child: new Wrap(
                alignment: WrapAlignment.center,
                children: sourcesWidget.toList(),
              ),
            ),
          ),
        ),
      ],
      // children: sourcesWidget.toList(),
    );
  }
}
