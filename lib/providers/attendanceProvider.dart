import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ibsmobile/data/attendance.dart';
import 'package:http/http.dart' as http;
import 'package:ibsmobile/constants/constant.dart';

class AttendanceProvider with ChangeNotifier {
  Attendance model = Attendance();
  bool loading = false;

  getData(context, szId) async{
    loading = true;
    model = await getSingleData(context, szId);
    loading = false;

    notifyListeners();
  }

  postData(context, attendance) async{
    loading = true;
    model = await postingData(context, attendance);
    loading = false;

    notifyListeners();
  }
}

Future<Attendance> postingData(context, att) async{
  Attendance result = Attendance();
  try{
    var dataInput = att.toJson();
    var  input = jsonEncode(dataInput);
    final response = await http.post(
      Uri.parse( await constant.szAPI() + 'SaveAttendance'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: input,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      String msg = json['szMessage'];

      if (json['szStatus'] == "success")   {
        var data = json['oResult'];
        result = Attendance.fromJson(data);
      }else{
        print(msg);
      }
    }
  }catch(e){
    print(e);
  }
  return result;
}


Future<Attendance> getSingleData(context, szId) async{
  Attendance result = Attendance();
  try{
    final response = await http.get(
      Uri.parse(await constant.szAPI() + 'GetAttendance'
          + '?'
          +'szEmployeeId=' + szId.toString()
      ),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      String msg = json['szMessage'];

      if (json['szStatus'] == "success") {
        var data = json['oResult'];
        result = Attendance.fromJson(data);
      }else{
        print(msg);
      }
    }
  }catch(e){
    print(e);
  }
  return result;
}
