import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibsmobile/data/callplan.dart';
import 'package:ibsmobile/pages/addnewcallplan.dart';
import 'package:ibsmobile/providers/callPlanProvider.dart';
import 'package:ibsmobile/widgets/dialog.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../data/customers.dart';
import '../data/user.dart';
import '../providers/customersProvider.dart';

class pickcustomers extends StatefulWidget {
  user? objUser;
  pickcustomers({super.key, this.objUser});

  @override
  State<pickcustomers> createState() => _pickcustomersState();
}

class _pickcustomersState extends State<pickcustomers> {
  List<OResult> _foundCustomers = [];
  List<OResult> _initCust = [];

  @override
  initState() {
    // at the beginning, all users are shown
    super.initState();
    final customers = Provider.of<CustomersProvider>(context, listen: false);
    final callplan = Provider.of<callplanProvider>(context, listen: false);

    customers.getData(
        context,
        widget.objUser!.szId
    );
    List<OResult>? oResult = customers.model.oResult;
    if(callplan.model.szDocId != null) {
      for (int x = 0; x < callplan.model.items!.length; x++) {
        Items item = callplan.model.items![x];
        oResult = oResult!.where((cust) =>
        cust.szId.toString().toLowerCase() !=
            (item.szCustomerId.toString().toLowerCase()))
            .toList();
      }
    }
    _foundCustomers = oResult!;
    _initCust = oResult;
  }

  void _runFilter(String enteredKeyword) {
    List<OResult> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _initCust;
    } else {
      results = _foundCustomers
          .where((cust) =>
          cust.szName.toString().toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundCustomers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color c = Color.fromRGBO(0, 133, 119, 1);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: c,
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: EdgeInsets.only(left: 5),
            child : TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                hintText: 'Search', suffixIcon: Icon(Icons.search),
                border: InputBorder.none
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child:
              _foundCustomers.isNotEmpty ? ListView.builder(
                shrinkWrap: true,
                itemCount: _foundCustomers.length,
                itemBuilder: (BuildContext context, int index){
                  return InkWell(
                    onTap: () {
                      CoolAlert.show(
                          context: context,
                          type: CoolAlertType.confirm,
                          text: "Adding Customers "+_foundCustomers[index].szName.toString(),
                          onConfirmBtnTap: () async {
                            final callplan = Provider.of<callplanProvider>(context, listen: false);
                            Callplan objCallplan = callplan.model;
                            Items item = Items();
                            String now = DateTime.now().year.toString()+"-"+DateTime.now().month.toString()+"-"+DateTime.now().day.toString()
                                +"T00:00:00";
                            OResult cust = _foundCustomers[index];

                            String uid = Uuid().v1().toString();

                            item.szDocId = uid;
                            item.szCustomerId = cust.szId;
                            item.dtmStart = now;
                            item.dtmFinish = now;
                            item.dtmReschedule = now;
                            item.bRescheduled = false;
                            item.bFinished = false;
                            item.bVisited = false;
                            item.customer = Customer.fromJson(cust.toJson());

                            if(objCallplan.items != null) {
                              objCallplan.items!.add(item);
                            }else{
                              objCallplan.szDocId = uid;
                              objCallplan.dtmDoc = now;
                              objCallplan.szEmployeeId = widget.objUser!.szId;
                              objCallplan.employee = Employee.fromJson(widget.objUser!.toJson());
                              objCallplan.dtmStart = now;
                              objCallplan.dtmFinished = now;
                              objCallplan.bStarted = false;
                              objCallplan.bFinished = false;
                              objCallplan.items = [item];
                            }

                            await callplan.postData(context, objCallplan);
                            Navigator.pop(context);
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.success,
                              text: "Customer ${cust.szName } has been Added!.",
                              onConfirmBtnTap: (){
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              }
                            );
                          },
                        );
                    },
                    child: Card(
                      child: ListTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _foundCustomers[index].szId.toString(),
                              style: TextStyle(
                                  fontSize: 16,
                              ),
                            ),
                            Text(
                                _foundCustomers[index].szName.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              _foundCustomers[index].szAddress.toString(),
                              style: TextStyle(
                                  fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ) : Center(
                child: Text(
                  'No results found',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

