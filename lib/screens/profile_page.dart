import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
          child: Image.asset('assets/martian.jpg'),
        ),
        new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new InkWell(
              onTap: () => print("Clicked"),
              child: new ListTile(
                leading: new Icon(Icons.feedback),
                title: new Text("Feedback"),
                trailing: new Switch(
                  activeColor: Theme.of(context).primaryColor,
                  value: true,
                  onChanged: (bool newValue) {
                    print("Something");
                  },
                ),
              ),
            ),
            new Divider(),
            new InkWell(
              onTap: () => print("Clicked"),
              child: new ListTile(
                leading: new Icon(Icons.info),
                title: new Text("About"),
              ),
            ),
            new Divider(),
            new InkWell(
              onTap: () => print("Clicked"),
              child: new ListTile(
                leading: new Icon(Icons.feedback),
                title: new Text("Feedback"),
              ),
            ),
            new Divider(),
          ],
        ),
      ],
    );
    // return new Center(child: new Text("Profile Page"));
  }
}
