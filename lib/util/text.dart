import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String title;

  TitleText(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 150.0, horizontal: 50.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 72.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
