import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ibsmobile/data/customers.dart';
import 'package:http/http.dart' as http;
import 'package:ibsmobile/constants/constant.dart';

class CustomersProvider with ChangeNotifier {
  Customers model = Customers();
  bool loading = false;

  getData(context, szId) async{
    loading = true;
    model = await getSingleData(context, szId);
    loading = false;

    notifyListeners();
  }
  postData(context, cust) async{
    loading = true;
    model = await postingData(context, cust);
    loading = false;

    notifyListeners();
  }
}

Future<Customers> postingData(context, cust) async{
  Customers result = Customers();
  try{
    var dataInput = cust.toJson();
    var  input = jsonEncode(dataInput);
    final response = await http.post(
      Uri.parse(await constant.szAPI()+ 'UpdateCustomerInfo'),
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
        result = Customers.fromJson(data);
      }else{
        print(msg);
      }
    }
  }catch(e){
    print(e);
  }
  return result;
}


Future<Customers> getSingleData(context, szId) async{
  Customers result = Customers();
  try{
    final response = await http.get(
      Uri.parse(await constant.szAPI()+ 'GetListCustomer'
          + '?'
          +'szEmployeeId=' + szId.toString()
      ),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      String msg = json['szMessage'];

      if (json['szStatus'] == "success") {
        var data = json;
        result = Customers.fromJson(data);
      }else{
        print(msg);
      }
    }
  }catch(e){
    print(e);
  }
  return result;
}
