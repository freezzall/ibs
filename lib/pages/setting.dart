import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class settingPage extends StatefulWidget {
  settingPage({Key? key}) : super(key: key);

  @override
  _settingPageState createState() => _settingPageState();
}

class _settingPageState extends State<settingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[

                Container(

                  decoration: BoxDecoration(
                      image: DecorationImage(
                          alignment: Alignment.topLeft,
                          image: AssetImage("images/headersetting.png"), fit: BoxFit.fitWidth)),
                  width: 400,
                  height: 300,

                  ),
                Text("Setting", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold ,color: Colors.black87),),

                SizedBox(height: 20,),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
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
                        onTap: (){},
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