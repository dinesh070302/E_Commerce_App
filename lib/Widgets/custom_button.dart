import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outlineButton;
  CustomButton({
    required this.text,
    required this.onPressed,
    required this.outlineButton,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: 60.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: outlineButton ? Colors.transparent : Colors.black,
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        // padding: const EdgeInsets.symmetric(
        //   horizontal: 24.0,
        //   vertical: 12.0,
        // ),
        margin: EdgeInsets.symmetric(
          vertical: 18.0,
          horizontal: 24.0,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.0,
            color: outlineButton ? Colors.black : Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
