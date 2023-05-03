import 'dart:ffi';

import 'package:animated_overflow/animated_overflow.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ibsmobile/data/callplan.dart';
import 'package:ibsmobile/pages/MapSheet.dart';
import 'package:ibsmobile/pages/mapscreen.dart';
import 'package:ibsmobile/pages/visit.dart';
import 'package:provider/provider.dart';

import '../providers/callPlanProvider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';


class customerlist extends StatefulWidget {
  final List<Items> item;
  Axis? orientation;
  customerlist({Key? key, required this.item, this.orientation}) : super(key: key);

  @override
  State<customerlist> createState() => _customerlistState();
}

class _customerlistState extends State<customerlist> {
  LatLng originPosition = LatLng(0, 0);

  Future<LatLng> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );

    return LatLng(position.latitude, position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    var item = widget.item;
    item.sort((a, b) {
      bool bVisited = b.bVisited!;
      if(!bVisited) {
        return 1;
      }
      return -1;
    });

    return Expanded(
      flex: 1,
        child:
        ListView.builder(
          shrinkWrap: true,
          scrollDirection: widget.orientation != null ? Axis.vertical : Axis.horizontal,
          itemCount: item.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.confirm,
                  text: "Visiting Customers "+item[index].customer!.szName.toString(),
                  onConfirmBtnTap: () async {
                    final callplan = Provider.of<callplanProvider>(context, listen: false);
                    Callplan objCallplan = callplan.model;
                    for(int x = 0 ; x < objCallplan.items!.length; x++){
                      Items itemSelector = objCallplan.items![x];
                      if(itemSelector.szCustomerId == item[index].szCustomerId) {
                        itemSelector.bVisited = true;
                        getLocation().then((value){
                          itemSelector.szLongitude = value.longitude.toString();
                          itemSelector.szLatitude = value.latitude.toString();
                        });
                      }
                    }
                    await callplan.postData(context, objCallplan);
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => visitPage(
                        selectedItem : item[index],
                        position: index,
                      )),
                    );
                    // CoolAlert.show(
                    //     context: context,
                    //     type: CoolAlertType.success,
                    //     text: "Customer ${item[index].customer!.szName } has been Visited!.",
                    //     onConfirmBtnTap: (){
                    //       Navigator.of(context).pop();
                    //     }
                    // );
                  },
                );
              },
              child: Container(
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
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        )
                    ),
                    // AnimatedOverflow(
                    //   animatedOverflowDirection: AnimatedOverflowDirection.VERTICAL,
                    //   child:
                    //   Flexible(
                    //     child:
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(item[index].customer!.szAddress.toString(),
                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      // ),
                      // maxHeight: 16,
                      // padding: 0.0,
                      // speed: 50.0,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap:(){
                            getLocation().then((value){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => mapscreen(
                                  objCustomer: item[index].customer,
                                  originPosition: value,
                                )),
                              );
                            });
                          },
                          child: Icon(Icons.my_location),
                        ),
                        SizedBox(width: 20,),
                        widget.orientation == null ?
                        InkWell(
                          onTap:(){
                            getLocation().then((origin){
                              MapsSheet.show(
                                context: context,
                                onMapTap: (map) {
                                  map.showDirections(
                                    destination: Coords(
                                      double.parse(item[index].customer!.szLatitude ?? "0"),
                                      double.parse(item[index].customer!.szLongitude ?? "0"),
                                    ),
                                    destinationTitle: "Destination",
                                    origin: Coords(origin.latitude, origin.longitude),
                                    originTitle: "My Location",
                                    // waypoints: waypoints,
                                    directionsMode: DirectionsMode.driving,
                                  );
                                  Navigator.pop(context);
                                },
                              );
                            });

                          },
                          child: Icon(Icons.directions),
                        )
                        :
                        InkWell(
                          onTap:(){
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.confirm,
                              text: "Removing Customers "+item[index].customer!.szName.toString(),
                              onConfirmBtnTap: () async {
                                final callplan = Provider.of<callplanProvider>(context, listen: false);
                                Callplan objCallplan = callplan.model;
                                objCallplan.items = objCallplan.items!.where((cust) =>
                                cust.szCustomerId.toString().toLowerCase() != (item[index].szCustomerId.toString().toLowerCase()))
                                    .toList();
                                await callplan.postData(context, objCallplan);
                                Navigator.pop(context);
                                CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.success,
                                    text: "Customer ${item[index].customer!.szName } has been Removed!.",
                                    onConfirmBtnTap: (){
                                      Navigator.of(context).pop();
                                    }
                                );
                              },
                            );
                          },
                          child: Icon(Icons.delete),
                        )

                      ],
                    )
                  ],
                ),
              ),
            );
          },
        )
    );
  }
}
