import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class card extends StatelessWidget {
  final double? width;
  final Widget? child;
  final Color? color;
  const card({Key? key, this.width, this.child, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: width,
        margin: EdgeInsets.all(3),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: color != null ? color : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: child,
      ),
    );
  }
}
