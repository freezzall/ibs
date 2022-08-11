import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ibsmobile/data/attendance.dart';
import 'package:ibsmobile/data/callplan.dart';
import 'package:ibsmobile/constants/constant.dart';

import 'package:http/http.dart' as http;
import 'package:ibsmobile/data/user.dart';
import 'package:ibsmobile/providers/attendanceProvider.dart';
import 'package:ibsmobile/providers/callPlanProvider.dart';
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

  String alert = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
  }

  @override
  void dispose() {
    // TODO: implement initState
    super.dispose();
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
                          onPressed: () {},
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
                  "List Customer : ${ objCallplan.items!.length } Tempat",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
                FloatingActionButton(
                  onPressed: () {},
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
                    children: [
                      Align(alignment: Alignment.topLeft , child: Text("Call Plan Hari ini", style: TextStyle(fontWeight: FontWeight.bold))),
                      roww(title: "Target", value: objCallplan.todayPerformance!.target.toString()),
                      roww(title: "Sukses", value: objCallplan.todayPerformance!.sukses.toString()),
                      roww(title: "Gagal", value: objCallplan.todayPerformance!.gagal.toString()),
                      roww(title: "Belum", value: objCallplan.todayPerformance!.belum.toString()),
                      roww(title: "Extra Call", value: objCallplan.todayPerformance!.extraCall.toString()),
                    ],
                  ),
                ),
                card(
                  child: Column(
                    children: [
                      Align(alignment: Alignment.topLeft , child: Text("MTD Performance", style: TextStyle(fontWeight: FontWeight.bold))),
                      roww(title: "Target", value: objCallplan.monthlyPerformance!.target.toString()),
                      roww(title: "Sukses", value: objCallplan.monthlyPerformance!.sukses.toString()),
                      roww(title: "Gagal", value: objCallplan.monthlyPerformance!.gagal.toString()),
                      roww(title: "Tidak Dikunjungi", value: objCallplan.monthlyPerformance!.tidakDiKunjungi.toString()),
                      roww(title: "Effective", value: objCallplan.monthlyPerformance!.effective.toString()),
                    ],
                  ),
                ),
              ],
            ),

            AbsensiUI()
          ],
        ),
      );
    }
  }
  Widget AbsensiUI(){
    return card(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                button(
                    text: "PAGI",
                    onTap: () {
                      objAttendance.bAttedancePagi = true;
                    },
                    color: !objAttendance.bAttedancePagi! ? null : Colors.grey
                ),
              SizedBox(width: 10),
              if(objAttendance.bAttedanceSore != null)
                button(
                    text: "SORE",
                    onTap: () {
                      objAttendance.bAttedanceSore = true;
                    },
                    color: !objAttendance.bAttedanceSore! && objAttendance.bAttedancePagi!  ? null : Colors.grey
                ),
            ],
          )

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
                image: AssetImage("images/header.png"), fit: BoxFit.fitWidth)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Halo, ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),),
                Text(widget.objUser!.szName.toString(), style: TextStyle(color: Colors.black,  fontWeight: FontWeight.bold),),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Cabang ", style: TextStyle(color: Colors.black, fontSize: 20),),
                    Text(widget.objUser!.szBranchNm.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
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

