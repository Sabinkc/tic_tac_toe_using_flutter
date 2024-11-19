import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final Color buttonColor;
  final Color titleColor;
  final Color borderColor;
  final void Function()? onTap;
  const CommonButton(
      {super.key,
      required this.title,
      required this.buttonColor,
      required this.titleColor,
      required this.borderColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor)),
        height: screenHeight * 0.09,
        width: screenWidth * 0.7,
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: titleColor, fontSize: screenWidth * 0.075),
          ),
        ),
      ),
    );
  }
}
