import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'alert.dart';
import '../pages/page.dart';
import '../pages/start_page.dart';
import '../pages/profile_info_page.dart';
import '../constants.dart';
import '../sheet_row.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  PrimaryButton({@required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: RaisedButton(
        child: Text(
          text,
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


class SubmitButton extends StatelessWidget {
  final bool done;
  final String path;
  final PageState state;
  final bool Function() condition;

  SubmitButton({this.done = false, this.path, @required this.state, this.condition}) : assert(done || path != null);

  void _confirm(BuildContext context) {
    List<Text> message = [
      Text('${sheetRow.firstName} ${sheetRow.lastName}'),
      Text(sheetRow.email),
      Text('Phone: ${sheetRow.phoneNum}'),
      Text('Class of ${sheetRow.gradYear}'),
      Text('${sheetRow.address}, ${sheetRow.city}, ${sheetRow.state} ${sheetRow.zip}')
    ];

    if (sheetRow.membershipType == 'Contact Info Only') {
      message.add(Text(sheetRow.membershipType));
    } else {
      message.addAll([
        Text('${sheetRow.membershipType} Membership'),
        Text('Jacket: ${sheetRow.jacketStyle} ${sheetRow.jacketSize}'),
        Text('Sports Program Format: ${sheetRow.sportsFormat}'),
        Text('Cap ${sheetRow.capPickedUp ? '' : 'not '}picked up'),
        Text('Jacket ${sheetRow.jacketPickedUp ? '' : 'not '}picked up'),
        Text('Payment ${sheetRow.paymentConfirmed ? '' : 'not '}confirmed'),
        Text('${sheetRow.capPickedUp ? 'I' : 'Not i'}nterested in joining the Dad\'s Club board'),
        Text('${sheetRow.capPickedUp ? 'I' : 'Not i'}nterested in volunteering at Bellarmine events'),
      ]);
    }

    alert(
        context: context,
        title: 'Are you sure you are done?',
        message: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: message,
        ),
        actions: [
          AlertButton(
            'Edit',
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName(ProfileInfoPage.path));
            },
          ),
          AlertButton(
            'Confirm',
            onPressed: () {
              Navigator.pop(context);
              _submit(context);
            },
          ),
        ]
    );
  }

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
              Navigator.popUntil(context, ModalRoute.withName(StartPage.path));
            },
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      text: done ? 'Complete' : 'Next',
      onPressed: () {
        if (condition == null || condition()) {
          state.update();
          if (done) {
            _confirm(context);
          } else {
            Navigator.pushNamed(context, path);
          }
        }
      },
    );
  }
}
