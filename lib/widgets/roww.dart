import 'package:flutter/cupertino.dart';

class roww extends StatelessWidget {
  final String? title;
  final String? value;
  final bool? bBold;

  const roww({
    this.title, this.value, this.bBold
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title!, style: TextStyle(fontSize: 16 , fontWeight: bBold != null ? FontWeight.bold : FontWeight.normal),),
        Text(value!, style: TextStyle(fontSize: 16, fontWeight: bBold != null ? FontWeight.bold : FontWeight.normal),),
      ],
    );
  }
}
