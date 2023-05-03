import 'dart:io';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:yaml/yaml.dart';

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
  File f = new File("../pubspec.yaml");
  String szVersion = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      szVersion = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {


    return EasySplashScreen(
      logo: Image(
        image: AssetImage("images/logo.png"),
      ),
      backgroundColor: Colors.blueGrey,
      showLoader: true,
      loadingText: Text(szVersion,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
      navigator: loginPage(),
      durationInSeconds: 3,
    );
  }
}