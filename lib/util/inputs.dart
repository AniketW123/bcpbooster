import 'package:flutter/material.dart';
import '../globals.dart';

class LabeledInput extends StatelessWidget {
  final String title;
  final Widget input;
  final bool noPadding;

  LabeledInput({@required this.title, @required this.input, this.noPadding = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: noPadding ? const EdgeInsets.all(0.0) : const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: noPadding ? FontWeight.w400 : FontWeight.w600
              ),
            ),
          ),
          input
        ],
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  SubmitButton({this.title = 'Next', @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: RaisedButton(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 28.0,
          ),
        ),
        color: primaryColor, // Hex: 2C3872
        textColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

