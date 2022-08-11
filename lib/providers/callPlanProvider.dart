import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ibsmobile/data/callplan.dart';
import 'package:http/http.dart' as http;
import 'package:ibsmobile/constants/constant.dart';

class callplanProvider with ChangeNotifier {
  Callplan model = Callplan();
  bool loading = false;

  getData(context, szId, date) async{
    loading = true;
    model = await getSingleData(context, szId, date);
    loading = false;

    notifyListeners();
  }
}

Future<Callplan> getSingleData(context, szId, date) async{
  Callplan result = Callplan();
  // date = "08/08/2022";
  try{
    final response = await http.get(
      Uri.parse(constant.szAPI + 'getCallPlan'
          + '?'
          +'szEmployeeId=' + szId.toString()
          + '&'
          +'dtmDoc='
          + date.toString()
      ),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      String msg = json['szMessage'];

      if (json['szStatus'] == "success") {
        var data = json['oResult'];
        result = Callplan.fromJson(data[0]);
      }else{
        print(msg);
      }
    }
  }catch(e){
    print(e);
  }
  return result;
}
