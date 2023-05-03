import 'package:flutter/material.dart';
import 'package:ibsmobile/data/user.dart';
import 'package:ibsmobile/pages/splashscreen.dart';
import 'package:ibsmobile/providers/attendanceProvider.dart';
import 'package:ibsmobile/providers/callPlanProvider.dart';
import 'package:ibsmobile/providers/customersProvider.dart';
import 'package:ibsmobile/providers/messageProvider.dart';
import 'package:ibsmobile/providers/surveyDetailProvider.dart';
import 'package:ibsmobile/providers/surveyProvider.dart';
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
  ChangeNotifierProvider(create: (_) => CustomersProvider()),
  ChangeNotifierProvider(create: (_) => surveyProvider()),
  ChangeNotifierProvider(create: (_) => surveyDetailProvider()),
  ChangeNotifierProvider(create: (_) => MessageProvider())
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //primarySwatch: Colors.grey,
      ),
      home: SplashPage(),
    );
  }
}
