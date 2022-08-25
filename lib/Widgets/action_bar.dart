import 'package:e_commerce_website/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomActionBar extends StatelessWidget {
  final String? title;
  final bool? hasBackArrow;
  final bool? hastitle;
  const CustomActionBar({this.title, this.hasBackArrow, this.hastitle});

  @override
  Widget build(BuildContext context) {
    bool _hastitle = hastitle ?? true;
    return Container(
      padding: const EdgeInsets.only(
        top: 56.0,
        left: 28.0,
        right: 24.0,
        bottom: 24.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (hasBackArrow ?? false)
            Container(
              child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.keyboard_backspace_outlined,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ),
          if (_hastitle)
            Text(
              title ?? "Action Bar",
              style: Constants.boldHeading,
            ),
          Container(
            width: 38.0,
            height: 38.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(8.0)),
            child: Text(
              "0",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
