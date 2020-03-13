import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants.dart';

class LabeledInput extends StatelessWidget {
  final String title;
  final Widget input;
  final bool isChoice;

  LabeledInput({@required this.title, @required this.input, this.isChoice = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isChoice ? const EdgeInsets.all(0.0) : const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: isChoice ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              title,
              style: inputStyle.copyWith(fontWeight: isChoice ? FontWeight.w400 : FontWeight.w600),
            ),
          ),
          input
        ],
      ),
    );
  }
}

class NumberTextField extends StatelessWidget {
  final InputDecoration decoration;
  final int maxLength;
  final void Function(String) onChanged;

  NumberTextField({this.decoration, this.maxLength, @required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: primaryColor,
      style: inputStyle,
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.phone,
      decoration: decoration,
      maxLength: maxLength,
      onChanged: onChanged,
      validator: (val) {
        if (val.length < maxLength) {
          return 'Must be $maxLength digits long.';
        }
        return null;
      },
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

