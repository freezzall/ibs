import 'dart:convert';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:cupertino_date_textbox/cupertino_date_textbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibsmobile/pages/camera.dart';
import 'package:ibsmobile/widgets/currencyformat.dart';
import 'package:ibsmobile/widgets/dateformat.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../data/callplan.dart';
import '../providers/callPlanProvider.dart';
import '../widgets/button.dart';
import '../widgets/roww.dart';
import 'gallery.dart';

import 'package:http/http.dart' as http;
import 'package:ibsmobile/constants/constant.dart';

class homeVisitPage extends StatefulWidget {
  Items? selectedItem;
  int? position;
  homeVisitPage({Key? key, this.selectedItem, this.position}) : super(key: key);

  @override
  State<homeVisitPage> createState() => _homeVisitPageState();
}

class _homeVisitPageState extends State<homeVisitPage> {
  String? dropdownValue;
  bool bFailed = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController noteInput = new TextEditingController();

  @override
  void initState() {
    super.initState();
    if(widget.selectedItem!.szStatus == "FAILED"){
      bFailed = true;
    }
    noteInput = TextEditingController(text: widget.selectedItem!.szNote);
  }

  Future<Images> getSingleData(context, szId) async{
    Images result = Images();
    // date = "08/08/2022";
    try{
      final response = await http.get(
        Uri.parse(await constant.szAPI() + 'getImage'
            + '?'
            +'szImageId=' + szId.toString()
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        String msg = json['szMessage'];

        if (json['szStatus'] == "success") {
          var data = json['oResult'];
          result = Images.fromJson(data);
        }else{
          print(msg);
        }
      }
    }catch(e){
      print(e);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final callplan = Provider.of<callplanProvider>(context);
    Color c = Color.fromRGBO(0, 133, 119, 1);

    void onDateChanged(date){
      // setState(() {
        String szDate = dateFormat.date(date.toString());
        widget.selectedItem!.bRescheduled = true;
        widget.selectedItem!.dtmReschedule = szDate;
      // });
    }

    Widget listAr(){
      List<Widget> list = [];

      for(int x =0; x < widget.selectedItem!.customer!.operArList!.length; x++){
        list.add(
            roww(
              title :dateFormat.dateOnly(widget.selectedItem!.customer!.operArList![x].dtmInstallment.toString()),
              value :CurrencyFormat.convertToIdr(widget.selectedItem!.customer!.operArList![x].decRemain),
            )
        );
      }

      return Column(
        children: list,
      );
    }

    Widget failedForm(){
      if(bFailed) {
        return Column(
          children: [
            Divider(),
            Align(alignment: Alignment.topLeft, child: Text("Reason")),
            DropdownButton<String>(
              value: widget.selectedItem!.szReasonId == "" ? "V0001" : widget
                  .selectedItem!.szReasonId,
              icon: const Icon(
                Icons.arrow_drop_down,
              ),
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: c,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  widget.selectedItem!.szReasonId = newValue!;
                });
              },
              items: callplan.model.reasons!
                  .where((Reasons element) =>
              element.szReasonType.toString()
                  .toUpperCase() == "VISIT")
                  .map((e) {
                return DropdownMenuItem<String>(
                  value: e.szId,
                  child: Text(e.szName.toString()),
                );
              }).toList(),
            ),
            Divider(),
            Align(alignment: Alignment.topLeft, child: Text("Tanggal Feedback")),
            CupertinoDateTextBox(
                initialValue: DateTime.parse(widget.selectedItem!.dtmReschedule.toString() ?? ""),
                onDateChange: onDateChanged,
                hintText: "Choose reschedule date"
            )

          ],
        );
      }else{
        return Container();
      }
    }

    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: c
              ),
              child : Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Card(
                      margin: EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Customer Info",
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Divider(color: c,),
                            Text(
                              widget.selectedItem!.customer!.szName.toString(),
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            roww(
                              title: "Customer ID",
                              value: widget.selectedItem!.szCustomerId.toString(),
                            ),
                            roww(
                              title: "Primary Contact",
                              value: widget.selectedItem!.customer!.szPhone1.toString(),
                            ),
                            roww(
                              title: "Secondary Contact",
                              value: widget.selectedItem!.customer!.szPhone2.toString(),
                            ),
                            Divider(
                              color: c,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex:6,
                                      child: roww(
                                        title : "Piutang",
                                        value: CurrencyFormat.convertToIdr(widget.selectedItem!.customer!.decTotalOpenAr),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: (){
                                          CoolAlert.show(
                                            context: context,
                                            type: CoolAlertType.warning,
                                            title: "Piutang",
                                            widget: Column(
                                              children: [
                                                roww(
                                                  title: "No. Invoice",
                                                  value: widget.selectedItem!.customer!.operArList![0].szDocPolisId,
                                                ),
                                                roww(
                                                  title: "No. Polis",
                                                  value: widget.selectedItem!.customer!.operArList![0].szDocPolisId,
                                                ),
                                                roww(
                                                  title: "Currency",
                                                  value: widget.selectedItem!.customer!.operArList![0].szCurrencyId,
                                                ),
                                                Divider(),
                                                roww(
                                                  title: "Tanggal",
                                                  value: "Sisa Piutang",
                                                  bBold: true,
                                                ),
                                                Divider(),
                                                listAr()
                                              ],
                                            ),
                                          );
                                        },
                                        child: Icon(Icons.receipt_long_outlined, color: c,)
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Status Visit"),
                    AnimatedToggleSwitch<bool>.dual(
                      current: bFailed,
                      first: false,
                      second: true,
                      dif: 50.0,
                      borderColor: Colors.transparent,
                      borderWidth: 5.0,
                      height: 55,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1.5),
                        ),
                      ],
                      onChanged: (b) => setState(() {
                        bFailed = b;
                        if(bFailed){
                          widget.selectedItem!.szStatus = "FAILED";
                        }else{
                          widget.selectedItem!.szStatus = "SUCCESS";
                        }
                      }),
                      colorBuilder: (b) => b ? Colors.red : Colors.green,
                      iconBuilder: (value) => value
                          ? Icon(Icons.close)
                          : Icon(Icons.check),
                      textBuilder: (value) => value
                          ? Center(child: Text('Failed'))
                          : Center(child: Text('Success')),
                    ),
                  ],
                ),
                Divider(),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: noteInput,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)
                      ),
                      labelText: "Note",
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    onChanged: (value){
                      widget.selectedItem!.szNote = value;
                    },
                  ),
                ),
                failedForm(),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: MaterialButton(
                        child: button(
                          icon: Icons.photo,
                          text: "Gallery",
                        ),
                        textColor: Colors.white,
                        color: c,
                        onPressed: () async{
                          List<Images> images = callplan.model!.items![widget.position!].images!;
                          List<Images> imagesReady = [];

                          CoolAlert.show(
                              context: context,
                              type: CoolAlertType.loading,
                              backgroundColor: c,
                              widget: Text("Please Wait"),
                              barrierDismissible: false
                          );
                          for(int x=0; x < images.length; x++){
                            await getSingleData(context, images[x].szImageId).then((value){
                              imagesReady.add(value);
                            });
                          }
                          Navigator.pop(context);

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => gallery(
                              images : imagesReady,
                            )),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 2,),
                    Expanded(
                      flex: 2,
                      child: MaterialButton(
                        child: button(
                          icon: Icons.camera_alt,
                          text: "Photo",
                        ),
                        textColor: Colors.white,
                        color: c,
                        onPressed: () async{
                          XFile? im = await ImagePicker().pickImage(
                            source: ImageSource.camera,
                            imageQuality: 25
                          );

                          im!.readAsBytes().then((value){
                            Callplan? objCallplan = callplan.model;
                            Images image = Images();
                            image.szDocId = objCallplan!.szDocId;
                            image.szCustomerId = widget.selectedItem!.szCustomerId;
                            image.szImageId = Uuid().v1().toString();
                            image.szImageBase64 = base64Encode(value);

                            callplan.saveImage(context, objCallplan, widget.selectedItem!.szCustomerId.toString(), image);
                          });


                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => camera(
                          //     szCustomerId: widget.selectedItem!.szCustomerId,
                          //     objCallplan: callplan.model,
                          //     selectedItem: widget.selectedItem,
                          //   )),
                          // );
                        },
                      ),
                    ),
                    SizedBox(width: 2,),
                    Expanded(
                      flex: 3,
                      child: MaterialButton(
                          child: button(
                            icon: Icons.save,
                            text: "Submit",
                          ),
                          textColor: Colors.white,
                          color: c,
                          onPressed: () async {
                            Callplan objCallplan = callplan.model;
                            for(int x = 0 ; x < objCallplan.items!.length; x++){
                              Items itemSelector = objCallplan.items![x];
                              if(itemSelector.szCustomerId == widget.selectedItem!.szCustomerId) {
                                widget.selectedItem!.images = itemSelector.images;
                                itemSelector = widget.selectedItem!;
                              }
                            }

                            widget.selectedItem!.bFinished = true;
                            widget.selectedItem!.dtmFinish = DateTime.now().toIso8601String();

                            List<Items> untouchItem = objCallplan.items!.where(
                                    (element) => element.szCustomerId != widget.selectedItem!.szCustomerId)
                                .toList();

                            Items touchItem = widget.selectedItem!;

                            objCallplan.items!.clear();
                            objCallplan.items!.add(touchItem);
                            objCallplan.items!.addAll(untouchItem);

                            await callplan.postData(context, objCallplan);
                            CoolAlert.show(
                                context: context,
                                type: CoolAlertType.success,
                                text: "Customer ${widget.selectedItem!.customer!.szName } has been Submitted!.",
                                onConfirmBtnTap: (){
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                }
                            );
                          }
                      ),
                    ),

                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
