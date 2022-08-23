import 'package:e_commerce_website/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomInput extends StatelessWidget {
  String hintText;
  CustomInput({required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Color(0xffF2F2F2),
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
          border: InputBorder.none,
          hintText: hintText,
        ),
        style: Constants.regularDarkText,
      ),
    );
  }
}
