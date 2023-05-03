import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ibsmobile/data/survey.dart';
import 'package:http/http.dart' as http;
import 'package:ibsmobile/constants/constant.dart';

class surveyDetailProvider with ChangeNotifier {
  Details model = Details();
  bool loading = false;

  setData(context, detail) async{
    loading = true;
    model = await setData(context, detail);
    loading = false;

    notifyListeners();
  }
}

Future<Details> setData(context, detail) async{
  Details result = Details();
  try{
    result = detail;
  }catch(e){
    print(e);
  }
  return result;
}

