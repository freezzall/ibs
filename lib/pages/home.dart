import 'dart:async';
import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ibsmobile/data/attendance.dart';
import 'package:ibsmobile/data/callplan.dart';
import 'package:ibsmobile/constants/constant.dart';

import 'package:http/http.dart' as http;
import 'package:ibsmobile/data/user.dart';
import 'package:ibsmobile/pages/addnewcallplan.dart';
import 'package:ibsmobile/pages/dailynews.dart';
import 'package:ibsmobile/providers/attendanceProvider.dart';
import 'package:ibsmobile/providers/callPlanProvider.dart';
import 'package:ibsmobile/providers/messageProvider.dart';
import 'package:ibsmobile/widgets/button.dart';
import 'package:ibsmobile/widgets/card.dart';
import 'package:ibsmobile/widgets/customerlist.dart';
import 'package:ibsmobile/widgets/roww.dart';
import 'package:provider/provider.dart';

class homePage extends StatefulWidget {
  user? objUser;
  homePage({Key? key, this.objUser}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  DateTime now = new DateTime.now();
  DateTime date = new DateTime.now();

  Color c = Color.fromRGBO(0, 133, 119, 1);

  late Callplan objCallplan = new Callplan();
  late Attendance objAttendance = new Attendance();
  List<DailyNews> listMessages = [];

  String alert = "";
  int intMessage = 0;

  //location variabel
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkGps();

    final callplan = Provider.of<callplanProvider>(context, listen: false);
    final attendance = Provider.of<AttendanceProvider>(context, listen: false);

    callplan.getData(
        context,
        widget.objUser!.szId,
        now.month.toString() + "/"
            + now.day.toString() + "/"
            + now.year.toString()
    );

    attendance.getData(context, widget.objUser!.szId);

    if(callplan.model.dailyNews != null) {
      intMessage = callplan.model.dailyNews!.where(
              (element) => !element.bRead!).length;
      listMessages.addAll(callplan.model.dailyNews!);
    }

  }

  addNew(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => addnewcallplan(objUser: widget.objUser)),
    );
  }

  @override
  void dispose() {
    // TODO: implement initState
    super.dispose();
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if(servicestatus){
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        }else if(permission == LocationPermission.deniedForever){
          print("'Location permissions are permanently denied");
        }else{
          haspermission = true;
        }
      }else{
        haspermission = true;
      }

      if(haspermission){
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    }else{
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();
  }

  setAbsensiPagi() async {
    final attendance = Provider.of<AttendanceProvider>(context, listen: false);
    objAttendance.bAttedancePagi = true;
    objAttendance.dtmAttedancePagi = DateTime.now().toIso8601String();
    await checkGps();
    objAttendance.szLatitudePagi = lat;
    objAttendance.szLongitudePagi = long;
    attendance.postData(context, objAttendance);
  }

  Future dialog(context, title, onTap) {
    return CoolAlert.show(
      context: context,
      type: CoolAlertType.confirm,
      title: "Confirmation",
      widget: Text(
        title
      ),
      onConfirmBtnTap: onTap
    );
  }

  setAbsensiSore() async{
    final attendance = Provider.of<AttendanceProvider>(context, listen: false);
    objAttendance.bAttedanceSore = true;
    objAttendance.dtmAttedanceSore = DateTime.now().toIso8601String();
    await checkGps();
    objAttendance.szLatitudeSore = lat;
    objAttendance.szLongitudeSore = long;
    attendance.postData(context, objAttendance);
  }

  List<Widget> getTodayPerformance(){
    if(objCallplan.todayPerformance != null){
      return [
        Align(alignment: Alignment.topLeft , child: Text("Call Plan Hari ini", style: TextStyle(fontWeight: FontWeight.bold))),
        roww(title: "Target", value: objCallplan.todayPerformance!.target.toString()),
        roww(title: "Sukses", value: objCallplan.todayPerformance!.sukses.toString()),
        roww(title: "Gagal", value: objCallplan.todayPerformance!.gagal.toString()),
        roww(title: "Belum", value: objCallplan.todayPerformance!.belum.toString()),
        roww(title: "Extra Call", value: objCallplan.todayPerformance!.extraCall.toString()),
      ];
    }else{
      String szZero = "0";
      return [
        Align(alignment: Alignment.topLeft , child: Text("Call Plan Hari ini", style: TextStyle(fontWeight: FontWeight.bold))),
        roww(title: "Target", value: szZero),
        roww(title: "Sukses", value: szZero),
        roww(title: "Gagal", value: szZero),
        roww(title: "Belum", value: szZero),
        roww(title: "Extra Call", value: szZero),
      ];
    }
  }

  List<Widget> getMonthlyPerformance(){
    if(objCallplan.monthlyPerformance!=null){
      return [
        Align(alignment: Alignment.topLeft , child: Text("MTD Performance", style: TextStyle(fontWeight: FontWeight.bold))),
        roww(title: "Target", value: objCallplan.monthlyPerformance!.target.toString()),
        roww(title: "Sukses", value: objCallplan.monthlyPerformance!.sukses.toString()),
        roww(title: "Gagal", value: objCallplan.monthlyPerformance!.gagal.toString()),
        roww(title: "Tidak Dikunjungi", value: objCallplan.monthlyPerformance!.tidakDiKunjungi.toString()),
        roww(title: "Effective", value: objCallplan.monthlyPerformance!.effective.toString()),
      ];
    }else{
      String szZero = "0";
      return [
        Align(alignment: Alignment.topLeft , child: Text("MTD Performance", style: TextStyle(fontWeight: FontWeight.bold))),
        roww(title: "Target", value: szZero),
        roww(title: "Sukses", value: szZero),
        roww(title: "Gagal", value: szZero),
        roww(title: "Tidak Dikunjungi", value: szZero),
        roww(title: "Effective", value: szZero),
      ];
    }
  }

  Widget CustomerUI() {
    if(objCallplan.szDocId == null) {
      return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  card(
                    color: Colors.redAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Data Callplan tidak tersedia ! ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                "Klik tombol disamping untuk menambahkan.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        FloatingActionButton(
                          onPressed: addNew,
                          mini: true,
                          elevation: 0,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.add, size: 30, color: Colors.redAccent,),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          )
      );
    }else{
      return Container(
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
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => dailynews(
                          listMessages: listMessages)
                      ),
                    );
                  },
                  child: Center(
                    child: Badge(
                      badgeColor: c,
                      showBadge: intMessage == 0 ? false : true,
                      badgeContent: Text(
                        "${intMessage}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      child: Icon(Icons.mail, size: 35, color: Colors.white),
                    ),
                    // child: Icon(Icons.mail,size: 35, color: Colors.white,),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "List Customer : ${ objCallplan.items!.length } Tempat",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
                FloatingActionButton(
                  onPressed: addNew,
                  mini: true,
                  elevation: 0,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.add, size: 30, color: c,),
                )
              ],
            ),
            customerlist(item: objCallplan.items!),
            Row(
              children: [
                card(
                  child:
                  Column(
                    children: getTodayPerformance(),
                  ),
                ),
                card(
                  child: Column(
                    children: getMonthlyPerformance(),
                  ),
                ),
              ],
            ),

            AbsensiUI(),
          ],
        ),
      );
    }
  }
  Widget AbsensiUI(){
    return card(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Absensi",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          ),
          Row(
            children: [
              if(objAttendance.bAttedancePagi != null)
                Expanded(
                  child: Container(
                    child: MaterialButton(
                      child: Text("PAGI"),
                      textColor: Colors.white,
                      disabledTextColor: Colors.white,
                      color: Colors.green,
                      disabledColor: Colors.grey,
                      onPressed: !objAttendance.bAttedancePagi! ?
                      () => dialog(
                          context,
                          "Morning Attendance", () async {
                            await setAbsensiPagi();
                            Navigator.pop(context);
                          }) : null
                    ),
                  ),
                ),

              SizedBox(width: 10),
              if(objAttendance.bAttedanceSore != null)
                Expanded(
                  child: Container(
                    child: MaterialButton(
                      child: Text("SORE"),
                        textColor: Colors.white,
                        disabledTextColor: Colors.white,
                        color: Colors.green,
                        disabledColor: Colors.grey,
                        onPressed: !objAttendance.bAttedanceSore! ?
                        () => dialog(
                          context,
                          "Afternoon Attendance", () async {
                          await setAbsensiSore();
                          Navigator.pop(context);
                        }): null
                    ),
                  ),
                ),
            ],
          ),

          // Text(servicestatus? "GPS is Enabled": "GPS is disabled."),
          // Text(haspermission? "GPS is Enabled": "GPS is disabled."),
          // Text("Longitude: $long", style:TextStyle(fontSize: 20)),
          // Text("Latitude: $lat", style: TextStyle(fontSize: 20),)

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final callplan = Provider.of<callplanProvider>(context);
    final attendance = Provider.of<AttendanceProvider>(context);
    objCallplan = callplan.model;
    objAttendance = attendance.model;

    return Scaffold(
      backgroundColor: c,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                alignment: Alignment.topLeft,
                image: AssetImage("images/header.png"),
                fit: BoxFit.fitWidth,
                opacity: 0.5
            )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leadingWidth: MediaQuery.of(context).size.width,
            leading: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Halo, ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 20),),
                  Text(widget.objUser!.szName.toString(), style: TextStyle(color: Colors.white,  fontWeight: FontWeight.bold, fontSize: 20),),
                ],
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Cabang ", style: TextStyle(color: Colors.white, fontSize: 20),),
                    Text(widget.objUser!.szBranchNm.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                  ],
                ),
              )
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Container(
            child : callplan.loading
                ? Container(
              child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Loading . . .",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  )
              ),
            )
                : CustomerUI()
          ),
        ),
      ),
    );
  }
}

