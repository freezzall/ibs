import 'dart:async';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ibsmobile/data/callplan.dart';
import 'package:provider/provider.dart';

import '../providers/customersProvider.dart';

class mapscreen extends StatefulWidget {
  Customer? objCustomer;
  LatLng? originPosition;
  mapscreen({Key? key, this.objCustomer, this.originPosition}) : super(key: key);

  @override
  State<mapscreen> createState() => _mapscreenState();
}

class _mapscreenState extends State<mapscreen> {
  Color c = Color.fromRGBO(0, 133, 119, 1);
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  double convertDouble(String s){
    if(s.isNotEmpty) {
      return double.parse(s);
    }else{
      return 0;
    }
  }

  postToServer() async {
    final customers = Provider.of<CustomersProvider>(context, listen: false);
    widget.objCustomer!.szLatitude = widget.originPosition!.latitude.toString();
    widget.objCustomer!.szLongitude = widget.originPosition!.longitude.toString();
    customers.postData(context, widget.objCustomer);
  }

  void executeAfterBuild(String szId){
    if(widget.objCustomer!.szLatitude == "") {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.confirm,
          title: "${szId}",
          widget: Text(
            "Customer ini tidak memiliki informasi lokasi."
                "Apakah anda berada di Sekitar lokasi Customer ini ?",
          ),
          onConfirmBtnTap: () {
            postToServer();
            Navigator.pop(context);
          },
          onCancelBtnTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          confirmBtnText: "Ya",
          cancelBtnText: "Tidak"
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => executeAfterBuild(widget.objCustomer!.szId.toString()));

    LatLng venuePosition = LatLng(
      convertDouble(widget!.objCustomer!.szLatitude.toString()),
      convertDouble(widget!.objCustomer!.szLongitude.toString()),
    );

    return new Scaffold(
      appBar: AppBar(
        backgroundColor: c,
        title: Text("Map"),
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        mapType: MapType.terrain,
        initialCameraPosition: CameraPosition(
          target: widget.objCustomer!.szLatitude != "" ? venuePosition : widget.originPosition!,
          zoom: 14.4746
        ),
        markers: {
          Marker(
            markerId: MarkerId("venuePosition"),
            position: venuePosition,
            infoWindow: InfoWindow(
                title: widget!.objCustomer!.szName.toString(),
                snippet: widget!.objCustomer!.szAddress.toString()
            ),
          ),
          Marker(
            markerId: MarkerId("originPosition"),
            position: widget.originPosition!,
          ),
        },
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

}
