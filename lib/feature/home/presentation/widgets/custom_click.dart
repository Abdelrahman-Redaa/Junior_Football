import 'package:flutter/material.dart';

class CustomClick extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;


  const CustomClick({
    super.key,
    required this.title,
    this.onTap,
    this.backgroundColor =  Colors.white,
    this.borderColor = const Color(0xff28A745),
    this.textColor = const Color(0xff28A745)
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}