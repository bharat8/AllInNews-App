import 'package:AllinNews/src/screens/news_list.dart';
import 'package:flutter/material.dart';

class DrawerSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          padding: EdgeInsets.only(left: 10, bottom: 30),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              'Choose a view',
              textScaleFactor: 1,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        ),
        ListTile(
          title: Text(
            'Cards',
            textScaleFactor: 1,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => NewsList(viewselected: "0")));
          },
        ),
        ListTile(
          title: Text(
            'List',
            textScaleFactor: 1,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => NewsList(viewselected: "1")));
          },
        ),
      ],
    ));
  }
}
