import 'package:flutter/material.dart';

class CustomElvatedButton extends StatelessWidget {
  const CustomElvatedButton(
      {super.key,
      required this.text,
      required this.backgroundColor,
      required this.borderSideColor,
      required this.style, required this.onPressed});
  final String text;
  final TextStyle style;
  final Color backgroundColor;
  final Color borderSideColor;
  final Function()? onPressed ;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 410,
        height: 48,
        child: ElevatedButton(
          
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: borderSideColor,
                width: 2,
              ),
            ),
          ),
          
          child: Text(
            text,
            style: style,
          ),
        ),
      ),
    );
  }
}
