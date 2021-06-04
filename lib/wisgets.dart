import 'package:blog_app/size_config.dart';
import 'package:flutter/material.dart';

class cWidget {
  static InputDecoration inputDecoration(
      {required String? lableText, required String? hintText}) {
    return InputDecoration(
        labelText: lableText,
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(sizeConfig.smallSize)));
  }

  static sizeBox({double? hieght, double? width}) {
    return SizedBox(height: hieght, width: width);
  }
}
