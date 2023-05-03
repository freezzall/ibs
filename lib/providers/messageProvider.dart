import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ibsmobile/data/attendance.dart';
import 'package:http/http.dart' as http;
import 'package:ibsmobile/constants/constant.dart';
import 'package:ibsmobile/data/callplan.dart';

class MessageProvider with ChangeNotifier {
  List<DailyNews> model = [];
  bool loading = false;

  getData(context, szId) async{
    loading = true;
    model = await getSingleData(context, szId);
    loading = false;

    notifyListeners();
  }
}

Future<List<DailyNews>> getSingleData(context, szId) async{
  List<DailyNews> result = [];
  try{
    final response = await http.get(
      Uri.parse(await constant.szAPI() + 'GetDailyNews'
          + '?'
          +'szEmployeeId=' + szId.toString()
      ),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      String msg = json['szMessage'];

      if (json['szStatus'] == "success") {
        result.add(json['oResult']);
      }else{
        print(msg);
      }
    }
  }catch(e){
    print(e);
  }
  return result;
}
