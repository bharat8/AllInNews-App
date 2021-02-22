import 'package:AllinNews/src/screens/news_list.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xff182952)),
      home: Scaffold(
        body: NewsList(
          viewselected: "0",
        ),
      ),
    );
  }
}
