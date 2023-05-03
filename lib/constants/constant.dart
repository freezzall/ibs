import 'package:shared_preferences/shared_preferences.dart';

class constant {
 static Future<String> szAPI() async {
  String result = "http://103.253.113.84/IBSMobileAPI/api/IBSMobileAPI/";

  final prefs = await SharedPreferences.getInstance();
  String? szAPI = prefs.getString('szAPI');
  if(szAPI != null){
   result = szAPI;
  }

  return result;
 }
}