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
}

Future<Attendance> getSingleData(context, szId) async{
  Attendance result = Attendance();
  try{
    final response = await http.get(
      Uri.parse(constant.szAPI + 'GetAttendance'
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
