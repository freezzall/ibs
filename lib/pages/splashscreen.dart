import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'login.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image(
        image: AssetImage("images/logo.png"),
      ),
      backgroundColor: Colors.blueGrey,
      showLoader: true,
      loadingText: Text("version 1.1.3",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
      navigator: loginPage(),
      durationInSeconds: 3,
    );
  }
}