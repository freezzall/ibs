import 'package:flutter/cupertino.dart';

class roww extends StatelessWidget {
  final String? title;
  final String? value;

  const roww({
    this.title, this.value
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title!, style: TextStyle(fontSize: 16),),
        Text(value!, style: TextStyle(fontSize: 16),),
      ],
    );
  }
}
