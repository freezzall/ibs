import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class aboutPage extends StatefulWidget {
  aboutPage({Key? key}) : super(key: key);

  @override
  _aboutPageState createState() => _aboutPageState();
}

class _aboutPageState extends State<aboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Text("HALAMAN ABOUT")
          ],
        ),
      ),
    );
  }
}