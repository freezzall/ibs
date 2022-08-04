import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[

            Container(
              margin: EdgeInsets.fromLTRB(0, 35, 300, 0),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  shape: BoxShape.circle
              ),
              child: InkWell(
                onTap: (){},
                child: Center(
                  child: Icon(Icons.message,size: 25, color: Colors.white,),
                ),
              ),
            ),

            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                    "List Customer : ",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                FloatingActionButton(
                  onPressed: () {},
                  mini: true,
                  elevation: 0,
                  child: Icon(Icons.add_circle_outline,size: 40, color: Colors.black,),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}