import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class button extends StatefulWidget {
  final String? text;
  final Color? color;
  final Color? textColor;
  final GestureTapCallback onTap;
  const button({Key? key, this.text, this.color, this.textColor, required this.onTap}) : super(key: key);

  @override
  State<button> createState() => _buttonState();
}

class _buttonState extends State<button> {
  Color c = Color.fromRGBO(0, 133, 119, 1);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          child: Material(
            child: InkWell(
              onTap: widget.onTap,
              child: InkWell(
                onTap: (){},
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Text(widget.text!,
                      style: TextStyle(
                          color: widget.textColor ?? Colors.white,
                          fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            color: Colors.transparent,
          ),
          color: widget.color ?? c,
        ),
    );
  }
}
