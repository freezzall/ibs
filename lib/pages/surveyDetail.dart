import 'dart:convert';
import 'dart:typed_data';

import 'package:cool_alert/cool_alert.dart';
import 'package:cupertino_date_textbox/cupertino_date_textbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibsmobile/providers/surveyDetailProvider.dart';
import 'package:ibsmobile/widgets/dateformat.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../data/survey.dart';
import '../providers/surveyProvider.dart';

class surveyDetail extends StatefulWidget {
  String? title;
  List<Items>? surveyItem;
  String? szCustomerId;
  String? szEmployeeId;
  surveyDetail({Key? key, this.surveyItem, this.title, this.szEmployeeId, this.szCustomerId}) : super(key: key);

  @override
  State<surveyDetail> createState() => _surveyDetailState();
}

class _surveyDetailState extends State<surveyDetail> {
  Color c = Color.fromRGBO(0, 133, 119, 1);
  int intPage = 1;
  bool bPassed = true;

  initText(List<Details> details, value){
    for(int x = 0; x < details.length; x++){
      Details detail = details[x];
      setState(() {
        detail.szAnswerValue = value.toString();
      });
    }
  }

  List<DropdownMenuItem<String>> initDropdown(Items items){
     List<DropdownMenuItem<String>> result = [];

     result.add(
         DropdownMenuItem<String>(
           value: "",
           child: Text("Please Choose One", style: TextStyle(fontSize: 16),),
         )
     );

     result.addAll(items.details!.map((e) {
        return DropdownMenuItem<String>(
          value: e.szAnswerText,
          child: Text(e.szAnswerText.toString(), style: TextStyle(fontSize: 16),),
        );
      }).toList());



     return result;
  }


  String initValueOption(Items items){
    String result = "";
    int iSelected = items.details!.where((element) => element.szAnswerValue == "SELECTED").length;

    for(int x = 0 ; x < items.details!.length; x++){
      if(items.details![x].szAnswerValue != null) {
        if(iSelected == 0){
          result = "";
        }else {
          result = items.details!
              .firstWhere((v) {
            if (v.szAnswerValue != "") {
              return v.szAnswerValue == "SELECTED";
            } else {
              return true;
            }
          })
              .szAnswerText.toString();
        }
      }
    }

    return result;
  }

  DateTime initValueDate(Items items){
    DateTime result = items.details!.first.szAnswerValue != null ?
    DateTime.parse(items.details!.first.szAnswerValue.toString()) : DateTime.now();

    if(items.details!.first.szAnswerValue == null){
      items.details!.first.szAnswerValue = DateTime.now().toIso8601String();
    }

    return result;
  }

  List<Widget> initCheckList(Items items){
    List<Widget> result = [];

    for (var v in items.details!) {
      result.add(
          Card(
            child: CheckboxListTile(
              title: Text(v.szAnswerText.toString()),
              value:  v.szAnswerValue != null ?
                  v.szAnswerValue== "SELECTED" ? true : false
                  : false,
              onChanged: (bool? newValue) {
                setState(() {
                  if(newValue!){
                    v.szAnswerValue = "SELECTED";
                  }else{
                    v.szAnswerValue = null;
                  }
                });
              },
            ),
          )
      );
    }


    return result;
  }

  List<Widget> initRadioGroup(Items items){
    List<Widget> result = [];

    for (var v in items.details!) {
      result.add(
          Card(
            child: RadioListTile<String>(
              title: Text(v.szAnswerText.toString()),
              groupValue: v.szDocId,
              value:  v.szAnswerText!,
              onChanged: (String? newValue) {
                setState(() {
                  for (var vv in items.details!) {
                    if (newValue! == vv.szAnswerText) {
                      v.szAnswerValue = "SELECTED";
                    } else {
                      v.szAnswerValue = "";
                    }
                  }
                });
              },
            ),
          )
      );
    }


    return result;
  }


  Widget initImage(Items items){
    Widget result = Container();

    if(items.details!.first.szAnswerValue != null) {
      Uint8List bytes = base64Decode(items.details!.first.szAnswerValue);
      result = Container(
          color: Colors.black,
          child: Image.memory(bytes)
      );
    }

    return result;
  }

  Widget initType(Items items){
    switch (items.szAnswerType) {
      case "TEXT":
      // do something
        TextEditingController controller = TextEditingController(
          text: items.details!.firstWhere((v) => v.szDocId == items.szDocId).szAnswerValue,
        );
        controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
        return TextFormField(
          controller: controller,
          onChanged: (value){
            initText(items.details!, value);
          },
          style: TextStyle(fontSize: 18),
        );
        break;
      case "OPTION":
        // return Column(
        //   children: initRadioGroup(items),
        // );
        return DropdownButton<String>(
          value: initValueOption(items),
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
              for (var value in items.details!) {
                value.szAnswerValue = null;
                if(value.szAnswerText == newValue){
                  value.szAnswerValue = "SELECTED";
                }
              }
              // items.details!.firstWhere((v) => v.szAnswerText == newValue).szAnswerValue = newValue!;
            });
          },
          items: initDropdown(items),
        );
      // do something else
        break;
      case "CHECKMARK":
      // do something else
        return Column(
          children: initCheckList(items),
        );
        break;
      case "DATE":
        return CupertinoDateTextBox(
            initialValue: initValueDate(items),
            onDateChange: (date){
            setState(() {
                String szDate = dateFormat.date(date.toString());
                items.details!.first.szAnswerValue = szDate;
              });
            },
            hintText: "Choose date"
        );
      // do something else
        break;
      case "IMAGE":
        return Column(
          children: [
            MaterialButton(
              onPressed: () async {
                XFile? im = await ImagePicker().pickImage(
                    source: ImageSource.camera,
                    imageQuality: 10
                );

                im!.readAsBytes().then((value){
                  setState(() {
                    items.details!.first.szAnswerValue = base64Encode(value);
                  });
                });
              },
              child: Container(
                child: Center(
                  child: Icon(Icons.camera_alt_rounded),
                ),
              ),
            ),
            initImage(items)
          ],
        );
      // do something else
        break;
    }
    
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    List<Items> objItem = widget.surveyItem!.where((element) => element.intPage == intPage).toList();
    double wSize = MediaQuery.of(context).size.width/3;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: c,
        title: Text("Survey " + widget.title.toString()),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: objItem.length,
                  itemBuilder: (BuildContext context, int index){
                    Items item = objItem[index];
                    String mandatory = "";
                    if(item.bMandatory!){
                      mandatory = "*";
                    }

                    return ListTile(
                      title: Container(
                        child : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.szQuestionNm.toString() + " " +
                              mandatory
                              ,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            initType(item)
                          ],
                        )
                      ),
                    );
                  }
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                intPage > widget.surveyItem!.first.intPage! ?
                Expanded(
                  child: MaterialButton(
                    onPressed: (){
                      setState(() {
                        intPage--;
                      });
                    },
                    child: Container(
                      child: Icon(Icons.arrow_back_ios, size: 35,),
                    ),
                  ),
                ) : SizedBox(width: wSize),
                intPage == widget.surveyItem!.last.intPage! ?
                Expanded(
                  child: MaterialButton(
                    onPressed: () async{
                      setState(() {
                        bPassed = checkMandatory(objItem);
                        // bPassed = true;
                      });

                      if(bPassed){
                        CoolAlert.show(
                          context: context,
                          type: CoolAlertType.loading,
                          barrierDismissible: false,
                          text: "Submitting Survey"
                        );
                        final provider = Provider.of<surveyProvider>(context, listen: false);
                        OResult objSurvey =  provider.model.oResult!.firstWhere((element) => element.szDocId == objItem.first.szDocId);
                        objSurvey.items = widget.surveyItem;
                        await provider.postData(context, objSurvey, widget.szCustomerId, widget.szEmployeeId);
                        Navigator.of(context).pop();
                        CoolAlert.show(
                            context: context,
                            type: CoolAlertType.success,
                            text: "Survey ${widget.title} has been Submitted!.",
                            onConfirmBtnTap: (){
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            }
                        );

                      }else{
                        dialogMandatory(context);
                      }
                    },
                    child: Container(
                      child: Icon(Icons.check_circle_outline_outlined, size: 45,),
                    ),
                  ),
                ) : SizedBox(width: wSize),
                intPage < widget.surveyItem!.last.intPage! ?
                Expanded(
                  child: MaterialButton(
                    onPressed: (){
                      bPassed = checkMandatory(objItem);

                      if(bPassed) {
                        setState(() {
                          intPage++;
                        });
                      }else{
                        dialogMandatory(context);
                      }
                    },
                    child: Container(
                      child: Icon(Icons.arrow_forward_ios, size: 35,),
                    ),
                  ),
                ) : SizedBox(width: wSize),
              ],
            )
          ],
        ),
      ),
    );
  }

  void dialogMandatory(BuildContext context) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: "Mandatory",
        widget: Text("Field must be Filled!")
    );
  }

  bool checkMandatory(List<Items> objItem) {
    List<Items> listMandatory = objItem.where((element) => element.bMandatory!).toList()!;

    for (var v in objItem) {
      if(v.bMandatory!){
        for (var vv in v.details!) {
          if(vv.szAnswerValue != null){
            if(vv.szAnswerValue.toString().isNotEmpty){
              listMandatory.remove(v);
            }
          }
        }
      }
    }

    if(listMandatory.isEmpty){
      bPassed = true;
    }else{
      bPassed = false;
    }
    return bPassed;
  }
}
