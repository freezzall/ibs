import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class dialog extends StatelessWidget {
  const dialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return showAlertDialog(context);
  }
}


showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget remindButton = TextButton(
    child: Text("Remind me later"),
    onPressed:  () {},
  );
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed:  () {},
  );
  Widget launchButton = TextButton(
    child: Text("Launch missile"),
    onPressed:  () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("Launching this missile will destroy the entire universe. Is this what you intended to do?"),
    actions: [
      remindButton,
      cancelButton,
      launchButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
