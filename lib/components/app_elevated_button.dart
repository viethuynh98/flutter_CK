import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton(
      {super.key,
      this.onPressed,
      required this.text,
      this.textColor = Colors.white,
      this.color = Colors.blue,
      this.height = 48.0});

  final Function()? onPressed;
  final String text;
  final Color textColor;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.center,
        height: height,
        decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.white, width: 1.2),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0.0, 3.0),
                color: Colors.black26,
                blurRadius: 6.0,
              )
            ]),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w500,
            fontSize: 16.8,
          ),
        ),
      ),
    );
  }
}
