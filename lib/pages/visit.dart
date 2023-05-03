
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibsmobile/pages/surveyVisitPage.dart';
import 'package:ibsmobile/widgets/roww.dart';

import '../data/callplan.dart';
import 'homeVisitPage.dart';

class visitPage extends StatefulWidget {
  Items? selectedItem;
  int? position;
  visitPage({Key? key, this.selectedItem, this.position}) : super(key: key);

  @override
  State<visitPage> createState() => _visitPageState();
}

class _visitPageState extends State<visitPage> {
  int currentIndex = 0;
  List<Widget> _screens() =>
      [
        homeVisitPage(selectedItem: widget.selectedItem, position: widget.position),
        surveyVisitPage(selectedItem: widget.selectedItem),
      ];

  @override
  Widget build(BuildContext context) {
    Color c = Color.fromRGBO(0, 133, 119, 1);
    final List<Widget> screens = _screens();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: c,
        elevation: 0,
        actions: [
          Container(
            padding: EdgeInsets.only(right: 10),
            width: 150,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                widget.selectedItem!.customer!.szAddress.toString(),
                textAlign: TextAlign.end,
                overflow: TextOverflow.visible,
                style: TextStyle(
                  fontSize: 16
                ),
              ),
            ),
          )
        ],
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: c,
        unselectedItemColor: Colors.grey,
        iconSize: 30,
        selectedFontSize: 18,
        unselectedFontSize: 12,
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Survey',
          ),
        ],
      ),
    );
  }
}
