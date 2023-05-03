import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibsmobile/data/callplan.dart';

import 'package:http/http.dart' as http;
import 'package:ibsmobile/constants/constant.dart';

class gallery extends StatefulWidget {
  List<Images>? images;
  gallery({Key? key, this.images}) : super(key: key);

  @override
  State<gallery> createState() => _galleryState();
}

class _galleryState extends State<gallery> {
  Color c = Color.fromRGBO(0, 133, 119, 1);

  @override
  Widget build(BuildContext context) {
    List<Images> images = widget.images!;

    return Scaffold(
      appBar: AppBar(title: Text("Gallery"), backgroundColor: c,),
      body: Container(
        padding: EdgeInsets.all(10),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: images.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
            childAspectRatio: 0.8
          ),
          itemBuilder: (BuildContext context, int index) {
            if(images[index].szImageBase64 != null) {
              Uint8List bytes = base64Decode(images[index].szImageBase64);
              return Container(
                color: Colors.black,
                  child: Image.memory(bytes)
              );
            }else{
              return Container();
            }
          },
        ),
      ),
    );
  }
}
