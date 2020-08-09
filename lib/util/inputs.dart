import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants.dart';

class LabeledInput extends StatelessWidget {
  final String title;
  final Widget input;
  final bool isChoice;

  LabeledInput({@required this.title, @required this.input, this.isChoice = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isChoice ? const EdgeInsets.all(0.0) : const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
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

class TextFieldPadding extends StatelessWidget {
  final int flex;
  final Widget child;

  TextFieldPadding({this.flex, @required this.child});

  @override
  Widget build(BuildContext context) {
    Padding padding = Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      child: child,
    );

    return flex == null ? padding : Expanded(
      flex: flex,
      child: padding,
    );
  }
}

class NumberTextField extends StatelessWidget {
  final String label;
  final int maxLength;
  final ValueChanged<String> onChanged;

  NumberTextField({this.label, this.maxLength, @required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: primaryColor,
      style: inputStyle,
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: label,
      ),
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

class WordsTextField extends StatelessWidget {
  final String label;
  final ValueChanged<String> onChanged;

  WordsTextField({this.label, @required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: primaryColor,
      style: inputStyle,
      textCapitalization: TextCapitalization.words,
      validator: (val) {
        if (val.length == 0) {
          return 'Must contain text.';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
      ),
      onChanged: onChanged,
    );
  }
}


class DropdownTextField extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  DropdownTextField({this.label, @required this.value, @required this.items, @required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 66.0,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 18.0,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            value: value,
            icon: Icon(Icons.keyboard_arrow_down),
            items: items.map((e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            )).toList(),
            isExpanded: true,
            style: inputStyle,
            underline: Container(
              height: 1,
              color: Colors.black45,
            ),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
