import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibsmobile/constants/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class settingPage extends StatefulWidget {
  settingPage({Key? key}) : super(key: key);

  @override
  _settingPageState createState() => _settingPageState();
}

class _settingPageState extends State<settingPage> {
  TextEditingController controller = TextEditingController();
  Color c = Color.fromRGBO(0, 133, 119, 1);

  @override
  void initState() {
    super.initState();
    constant.szAPI().then((value) => controller.text = value);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: c,
        title: Text("Setting"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[

                // Container(
                //
                //   decoration: BoxDecoration(
                //       image: DecorationImage(
                //           alignment: Alignment.topLeft,
                //           image: AssetImage("images/headersetting.png"), fit: BoxFit.fitWidth)),
                //   width: 400,
                //   height: 300,
                //   padding: EdgeInsets.only(top: 50, left: 10),
                //   child: Align(
                //       alignment: Alignment.topLeft,
                //       child: Icon(Icons.arrow_back_ios)
                //   ),
                //
                //   ),
                // Text("Setting", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold ,color: Colors.black87),),

                SizedBox(height: 20,),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)
                      ),
                      labelText: "Host",
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),

                SizedBox(height: 20,),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    child: Container(
                      height: 50,
                      child: InkWell(
                        splashColor: Colors.black,
                        onTap: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setString('szAPI', controller.text);
                          CoolAlert.show(
                              context: context,
                              type: CoolAlertType.success,
                              text: "Host Information has been changed!.",
                              onConfirmBtnTap: (){
                                Navigator.of(context).pop();
                              }
                          );
                        },
                        child: Center(
                          child: Icon(Icons.save_as, size: 40, color: Colors.black,),
                        ),
                      ),
                    ),
                  ),
                ),

              ]
          ),
        ),
      ),
    );
  }
}