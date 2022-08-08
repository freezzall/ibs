import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibsmobile/data/callplan.dart';
import 'package:ibsmobile/constants/constant.dart';

import 'package:http/http.dart' as http;
import 'package:ibsmobile/widgets/customerlist.dart';

class homePage extends StatefulWidget {
  homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  late Callplan objCallplan = new Callplan();
  late List<Items> objCallplanItem = [];
  String alert = "";

  Future<bool> getData() async {
    final response = await http.get(
      Uri.parse(constant.szAPI + 'getCallPlan'
          + '?'
          +'szEmployeeId=' + '615'
          + '&'
          +'dtmDoc='+ '08/08/2022'
      ),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      String result = json['szMessage'];

      if(json['szStatus'] == "success") {
        setState(() {
          alert = result;
          var data = json['oResult'];
          objCallplan= Callplan.fromJson(data[0]);
          objCallplanItem = objCallplan.items!;
        });
        return true;
      }else{
        setState(() {
          alert = result;
        });
        return false;
      }
    } else {
      setState((){
        alert = 'Login Failed';
      });
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Halo, ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),),
            Text("Ageonathan Darien", style: TextStyle(color: Colors.black,  fontWeight: FontWeight.bold),),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Cabang ", style: TextStyle(color: Colors.black, fontSize: 20),),
                Text("DKI Jakarta", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
              ],
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle
                ),
                child: InkWell(
                  onTap: (){},
                  child: Center(
                    child: Icon(Icons.mail,size: 35, color: Colors.white,),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                    "List Customer : ${ objCallplanItem.length } Tempat",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                ),
                FloatingActionButton(
                  onPressed: () {},
                  mini: true,
                  elevation: 0,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.add, size: 30, color: Colors.green,),
                )
              ],
            ),
            customerlist(item: objCallplanItem),

          ],
        ),
      ),
    );
  }
}