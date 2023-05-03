import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibsmobile/data/survey.dart';
import 'package:ibsmobile/pages/surveyDetail.dart';
import 'package:provider/provider.dart';

import '../data/callplan.dart' as cp;
import '../providers/callPlanProvider.dart';
import '../providers/surveyProvider.dart';

class surveyVisitPage extends StatefulWidget {
  cp.Items? selectedItem;
  surveyVisitPage({Key? key, this.selectedItem}) : super(key: key);

  @override
  State<surveyVisitPage> createState() => _surveyVisitPageState();
}

class _surveyVisitPageState extends State<surveyVisitPage> {
  String szEmployeeId = "";

  @override
  void initState() {
    final surveys = Provider.of<surveyProvider>(context, listen: false);
    final callplan = Provider.of<callplanProvider>(context, listen: false);
    surveys.getData(
        context,
        callplan.model.employee!.szId,
        widget.selectedItem!.szCustomerId,
        DateTime.now().month.toString() + "/" +
        DateTime.now().day.toString() + "/" +
        DateTime.now().year.toString()
    );
    szEmployeeId = callplan.model.employee!.szId!;
  }


  @override
  Widget build(BuildContext context) {
    final surveys = Provider.of<surveyProvider>(context);
    Color c = Color.fromRGBO(0, 133, 119, 1);

    return Container(
      child: surveys.loading ?
      Container(
        child: Center(
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
          ),
        ),
      )
      : surveys.model.oResult!.isNotEmpty ? ListView.builder(
          itemCount: surveys.model.oResult!.length,
          itemBuilder: (BuildContext context, int index){
            OResult objSurvey = surveys.model.oResult![index];
            return ListTile(
              title : Card(
                elevation: 2,
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => surveyDetail(
                        surveyItem: objSurvey.items,
                        title: objSurvey.szSurveyId,
                        szEmployeeId : szEmployeeId,
                        szCustomerId : widget.selectedItem!.szCustomerId,
                      )),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          surveys.model.oResult![index].szSurveyId.toString(),
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          surveys.model.oResult![index].szSurveyNm.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
      )
      : Container(
        child: Center(
            child: Text(
              "There's no Surveys Data . . .",
              style: TextStyle(
                fontSize: 18,
              ),
            )
        )
      )
    );
  }

}
