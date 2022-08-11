import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ibsmobile/data/user.dart';
import 'package:http/http.dart' as http;
import 'package:ibsmobile/constants/constant.dart';
import 'package:toast/toast.dart';

class userProvider with ChangeNotifier {
  user model = user();
  bool loading = false;

  getData(context, szId, szPassword) async{
    loading = true;
    model = await getSingleData(context, szId, szPassword);
    loading = false;

    notifyListeners();
  }
}

Future<user> getSingleData(context, szId, szPassword) async{
  user result = user();
  try{
    final response = await http.post(
      Uri.parse(constant.szAPI + 'login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'szId': szId,
        'szPassword': szPassword
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      String msg = json['szMessage'];

      if (json['szStatus'] == "success") {
        result = user.fromJson(json['oResult']);
      }else{
        print(msg);
      }
    }
  }catch(e){
    print(e);
  }
  return result;
}
