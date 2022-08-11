import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibsmobile/data/callplan.dart';

class customerlist extends StatefulWidget {
  final List<Items> item;
  const customerlist({Key? key, required this.item}) : super(key: key);

  @override
  State<customerlist> createState() => _customerlistState();
}

class _customerlistState extends State<customerlist> {
  @override
  Widget build(BuildContext context) {
    var item = widget.item;

    return Expanded(
      flex: 1,
        child:
        ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: item.length,
          itemBuilder: (context, index) {
            return Container(
              width: 280,
              margin: EdgeInsets.all(3),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // for (int x = 0 ; x < objCallplan.items.length(0) ; x++ )
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item[index].szCustomerId.toString()),
                      if(item[index].bVisited as bool)
                        Icon(Icons.radio_button_checked_outlined, color: Colors.green,)
                      else
                        Icon(Icons.radio_button_checked_outlined, color: Colors.red,)
                    ],
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(item[index].customer!.szName.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      )
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(item[index].customer!.szAddress.toString(),
                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
                      )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap:(){},
                        child: Icon(Icons.my_location),
                      ),
                      SizedBox(width: 20,),
                      InkWell(
                        onTap:(){},
                        child: Icon(Icons.directions),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        )
    );
  }
}
