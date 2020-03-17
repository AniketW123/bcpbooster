import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'alert.dart';
import '../page.dart';
import '../../constants.dart';
import '../../sheet_row.dart';

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
    return Container(
      padding: EdgeInsets.only(top: 0.0),
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

class SubmitButton extends StatelessWidget {
  final bool done;
  final String path;
  final PageState state;
  final bool Function() condition;

  SubmitButton({this.done = false, this.path, @required this.state, this.condition}) : assert(done || path != null);

  void _submit(BuildContext context) async {
    state.startLoading();

    http.Response res = await http.post(
      'https://sheets.googleapis.com/v4/spreadsheets/$sheetId/values/1:1:append?valueInputOption=USER_ENTERED',
      headers: await googleSignIn.currentUser.authHeaders,
      body: jsonEncode({
        'majorDimension': 'ROWS',
        'values': [sheetRow.getList()]
      }),
    );

    state.stopLoading();

    if (res.statusCode == 200) {
      alert(
        context: context,
        title: 'Done!',
        message: Text('Response recorded for ${sheetRow.firstName} ${sheetRow.lastName}.'),
        actions: <Widget>[
          AlertButton(
            'OK',
            onPressed: () {
              sheetRow = SheetRow();
              Navigator.pushNamed(context, '/profile_info');
            },
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: RaisedButton(
        child: Text(
          done ? 'Done' : 'Next',
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
        onPressed: () {
          if (condition == null || condition()) {
            state.update();
            if (done) {
              _submit(context);
            } else {
              Navigator.pushNamed(context, path);
            }
          }
        },
      ),
    );
  }
}

