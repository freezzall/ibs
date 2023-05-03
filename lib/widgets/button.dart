import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class button extends StatefulWidget {
  final String? text;
  final Color? color;
  final Color? textColor;
  final IconData? icon;
  button({Key? key, this.text, this.color, this.textColor, this.icon}) : super(key: key);

  @override
  State<button> createState() => _buttonState();
}

class _buttonState extends State<button> {
  Color c = Color.fromRGBO(0, 133, 119, 1);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Icon(widget.icon!),
          Text(widget.text!, style: TextStyle(
            fontSize: 16
          ),),
        ],
      ),
    );
  }
}
