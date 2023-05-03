import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibsmobile/widgets/dateformat.dart';

import '../data/callplan.dart';

class dailynews extends StatefulWidget {
  List<DailyNews> listMessages;
  dailynews({Key? key, required this.listMessages}) : super(key: key);

  @override
  State<dailynews> createState() => _dailynewsState();
}

class _dailynewsState extends State<dailynews> {
  Color c = Color.fromRGBO(0, 133, 119, 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: c,
        title: Text("Daily News"),
      ),
      body: PageView.builder(
        itemCount: widget.listMessages.length,
        onPageChanged: (page){
          // setState(() {
          //   widget.listMessages[page].bRead = true;
          // });
        },
        itemBuilder: (context, position) {
          DailyNews msg = widget.listMessages[position];
          return Container(
            margin: EdgeInsets.all(10),
            child: Card(
              child: Container(
                padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Messages",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Divider(thickness: 2,),
                      Text(
                        "Periode : \n"
                            + dateFormat.dateOnly(msg.dtmFrom!)
                        + " - "
                            + dateFormat.dateOnly(msg.dtmTo!),
                        style: TextStyle(
                            fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        msg.szMessage.toString(),
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                      Spacer(),
                      Center(
                        child: Text(
                          "Message " +
                          (position+1).toString() +
                          " of " + widget.listMessages.length.toString(),
                          style: TextStyle(
                              fontSize: 18
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ),
          );
        },
      ),
    );
  }
}
