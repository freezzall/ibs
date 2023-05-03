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

  storeImage(context, cp, szCustomerId, images) async{
    loading = true;
    model = await storingImage(context, cp, szCustomerId, images);
    loading = false;

    notifyListeners();
  }

  saveImage(context, cp, szCustomerId, images) async{
    loading = true;
    model = await savingImage(context, cp, szCustomerId, images);
    loading = false;

    notifyListeners();
  }

  postData(context, cp) async{
    loading = true;
    model = await postingData(context, cp);
    loading = false;

    notifyListeners();
  }
}

Future<Callplan> storingImage(context, cp, szCustomerId, images) async{
  Callplan result = Callplan();
  try{
    for(int x = 0 ; x < cp.items!.length; x++){
      Items itemSelector = cp.items![x];
      if(itemSelector.szCustomerId == szCustomerId) {
        itemSelector.images!.addAll(images);
        itemSelector.images = itemSelector.images!.where((element) => element.szImageBase64 != null).toList();
      }
    }
    result = cp;
  }catch(e){
    print(e);
  }
  return result;
}

Future<Callplan> savingImage(context, cp, szCustomerId, images) async{
  Callplan result = Callplan();
  try{
    var dataInput = images.toJson();
    var  input = jsonEncode(dataInput);
    final response = await http.post(
      Uri.parse(await constant.szAPI() + 'SaveImage'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: input,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      String msg = json['szMessage'];

      if (json['szStatus'] == "success")   {
        result = await getSingleData(
            context,
            cp.szEmployeeId,
            DateTime.now().month.toString() + "/" +
            DateTime.now().day.toString() + "/" +
            DateTime.now().year.toString()
        );
      }else{
        result = cp;
      }
    }
  }catch(e){
    print(e);
  }
  return result;
}

Future<Callplan> getSingleData(context, szId, date) async{
  Callplan result = Callplan();
  // date = "08/08/2022";
  try{
    final response = await http.get(
      Uri.parse(await constant.szAPI() + 'getCallPlan'
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
        result = Callplan.fromJson(data [0]);
      }else{
        print(msg);
      }
    }
  }catch(e){
    print(e);
  }
  return result;
}

Future<Callplan> postingData(context, cp) async{
  Callplan result = Callplan();
  try{
    var dataInput = cp.toJson();
    var  input = jsonEncode(dataInput);
    final response = await http.post(
      Uri.parse(await constant.szAPI() + 'SaveCallPlan'),
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
        result = Callplan.fromJson(data);
      }else{
        result = cp;
      }
    }
  }catch(e){
    print(e);
  }
  return result;
}
