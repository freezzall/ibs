import 'package:flutter/material.dart';
import 'package:ibsmobile/data/user.dart';
import 'package:ibsmobile/pages/splashscreen.dart';
import 'package:ibsmobile/providers/attendanceProvider.dart';
import 'package:ibsmobile/providers/callPlanProvider.dart';
import 'package:ibsmobile/providers/userProvider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  runApp(
      MultiProvider(
        providers: providers,
        child: MyApp()
      )
  );
}

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => userProvider()),
  ChangeNotifierProvider(create: (_) => callplanProvider()),
  ChangeNotifierProvider(create: (_) => AttendanceProvider()),
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //primarySwatch: Colors.grey,
      ),
      home: SplashPage(),
    );
  }
}
