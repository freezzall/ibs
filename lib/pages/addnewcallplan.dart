import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibsmobile/data/callplan.dart';
import 'package:ibsmobile/data/user.dart';
import 'package:ibsmobile/pages/pickcustomers.dart';
import 'package:ibsmobile/providers/callPlanProvider.dart';
import 'package:ibsmobile/widgets/customerlist.dart';
import 'package:provider/provider.dart';

import '../data/customers.dart';
import '../providers/customersProvider.dart';

class addnewcallplan extends StatefulWidget {
  user? objUser;
  addnewcallplan({Key? key, this.objUser}) : super(key: key);

  @override
  State<addnewcallplan> createState() => _addnewcallplanState();
}

class _addnewcallplanState extends State<addnewcallplan> {
  final int dateRange = 3;
  Color c = Color.fromRGBO(0, 133, 119, 1);
  String _selectedValue = "";
  Callplan objCallplan = new Callplan();
  Customers objCustomers = Customers();
  DatePickerController datePickerController = DatePickerController();
  DateTime? sDate;
  List<DateTime> daysInBetween = [];

  List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  @override
  void initState() {
    super.initState();
    sDate = DateTime.now();
    String date = DateTime.now().month.toString() + "/"
        + DateTime.now().day.toString() + "/"
        + DateTime.now().year.toString();
    getCallplan(date);
    getCustomers();
    daysInBetween = getDaysInBetween(
        DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day - dateRange),
        DateTime.now()
    );
  }

  void getCallplan(String date){
    final callplan = Provider.of<callplanProvider>(context, listen: false);
    callplan.getData(
        context,
        widget.objUser!.szId,
        date
    );
    setState(() {
      objCallplan = callplan.model;
    });
  }

  void getCustomers(){
    final customers = Provider.of<CustomersProvider>(context, listen: false);
    customers.getData(
        context,
        widget.objUser!.szId
    );
    setState(() {
      objCustomers = customers.model;
    });

  }

  Widget DataUI(){
    if(objCallplan.items != null) {
      return customerlist(item: objCallplan.items!, orientation: Axis.horizontal);
    }else{
      return Container();
    }
  }

  void executeAfterBuild(){
    datePickerController.animateToDate(sDate!);
    // getCustomers();
  }

  @override
  Widget build(BuildContext context) {
    final customers = Provider.of<CustomersProvider>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) => executeAfterBuild());

    final callplan = Provider.of<callplanProvider>(context);
    objCallplan = callplan.model;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: c,

        title: Text("List Customer"),
        actions: [
          customers.loading ?
              Container()
          : Container(
            padding: EdgeInsets.all(10),
            child: InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => pickcustomers(objUser: widget.objUser)),
                );
              },
              child: Icon(Icons.add_business_outlined, size: 35,),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            child: DatePicker(
              DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day - dateRange),
              initialSelectedDate: DateTime.now(),
              controller: datePickerController,
              selectionColor: c,
              selectedTextColor: Colors.white,
              activeDates: daysInBetween,
              onDateChange: (date) {
                // New date selected
                setState(() {
                  sDate = date;
                  _selectedValue = date.month.toString() + "/"
                  + date.day.toString() + "/"
                  + date.year.toString();

                  getCallplan(_selectedValue);
                });
                print(_selectedValue);
              },
            ),
          ),
          callplan.loading
              ? Container(
            child: Expanded(
              flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: c,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Loading . . .",
                      style: TextStyle(
                          fontSize: 20,
                          color: c,
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                )
            ),
          )
          : DataUI()
        ],
      ),

    );
  }
}
