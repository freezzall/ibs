import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class logoutPage extends StatefulWidget {
  const logoutPage({Key? key}) : super(key: key);

  @override
  State<logoutPage> createState() => _logoutPageState();
}

class _logoutPageState extends State<logoutPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero, () async {
      logout();
    });
  }

  logout() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => loginPage()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
