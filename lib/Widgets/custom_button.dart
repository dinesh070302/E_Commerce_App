import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outlineButton;
  final bool isFormLoading;
  CustomButton({
    required this.text,
    required this.onPressed,
    required this.outlineButton,
    required this.isFormLoading,
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
        margin: const EdgeInsets.symmetric(
          vertical: 18.0,
          horizontal: 24.0,
        ),
        child: Stack(
          children: [
            Visibility(
              visible: isFormLoading ? false : true,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: outlineButton ? Colors.black : Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Visibility(
                visible: isFormLoading,
                child: Center(
                  child: SizedBox(
                    height: 30.0,
                    width: 30.0,
                    child: CircularProgressIndicator(),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
