import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ibsmobile/data/survey.dart';
import 'package:http/http.dart' as http;
import 'package:ibsmobile/constants/constant.dart';

class surveyProvider with ChangeNotifier {
  survey model = survey();
  bool loading = false;

  getData(context, szId, szCustomerId, date) async{
    loading = true;
    model = await getSingleData(context, szId, szCustomerId, date);
    loading = false;

    notifyListeners();
  }
  postData(context, cust, szCustomerId, szEmployeeId) async{
    loading = true;
    model = await postingData(context, cust, szCustomerId, szEmployeeId);
    loading = false;

    notifyListeners();
  }
}

Future<survey> postingData(context, cust, szCustomerId, szEmployeeId) async{
  survey result = survey();
  try{
    var dataInput = cust.toJson();
    var  input = jsonEncode(dataInput);
    final response = await http.post(
      Uri.parse(await constant.szAPI()+ 'SaveDocSurvey'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: input,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      String msg = json['szMessage'];

      if (json['szStatus'] == "success")   {
        await getSingleData(
            context,
            szEmployeeId,
            szCustomerId,
            DateTime.now().month.toString() + "/" +
                DateTime.now().day.toString() + "/" +
                DateTime.now().year.toString()
        ).then((value) => (
        result = value
        ));
      }else{
        print(msg);
      }
    }
  }catch(e){
    print(e);
  }
  return result;
}


Future<survey> getSingleData(context, szId, szCustomerId, date) async{
  survey result = survey();
  try{
    final response = await http.get(
      Uri.parse(await constant.szAPI()+ 'GetListDocSurvey'
          + '?'
          +'szEmployeeId=' + szId.toString() + "&"
          +'szCustomerId=' + szCustomerId.toString() + "&"
          +'dtmDate=' + date.toString()
      ),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      String msg = json['szMessage'];

      if (json['szStatus'] == "success") {
        var data = json;
        result = survey.fromJson(data);
      }else{
        print(msg);
      }
    }
  }catch(e){
    print(e);
  }
  return result;
}
