import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../globals.dart';
import '../sheet_row.dart';
import '../util/alert.dart';
import '../util/inputs.dart';

class SwagPage extends StatefulWidget {
  @override
  _SwagPageState createState() => _SwagPageState();
}

class _SwagPageState extends State<SwagPage> {
  bool _capPickedUp = sheetRow.capPickedUp;
  bool _jacketPickedUp = sheetRow.jacketPickedUp;
  bool _paymentConfirmed = sheetRow.paymentConfirmed;

  void _update() {
    sheetRow.capPickedUp = _capPickedUp;
    sheetRow.jacketPickedUp = _jacketPickedUp;
    sheetRow.paymentConfirmed = _paymentConfirmed;
  }

  void _submit() async {
    http.Response res = await http.post(
      'https://sheets.googleapis.com/v4/spreadsheets/$sheetId/values/A1:R1:append?valueInputOption=USER_ENTERED',
      headers: await googleSignIn.currentUser.authHeaders,
      body: jsonEncode({
        'majorDimension': 'ROWS',
        'range': 'A1:R1',
        'values': [sheetRow.getList()]
      }),
    );

    print(res.body);
    if (res.statusCode == 200) {
      alert(
        context: context,
        title: 'Done!',
        message: 'Response recorded for ${sheetRow.firstName} ${sheetRow.lastName}.',
        actions: <Widget>[
          AlertButton(
            'OK',
            onPressed: () {
              sheetRow = SheetRow();
            },
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment and Swag'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            LabeledInput(
              title: 'Cap picked up?',
              input: Checkbox(
                value: _capPickedUp,
                onChanged: (val) {
                  setState(() {
                    _capPickedUp = val;
                  });
                },
              ),
            ),
            LabeledInput(
              title: 'Jacket picked up?',
              input: Checkbox(
                value: _jacketPickedUp,
                onChanged: (val) {
                  setState(() {
                    _jacketPickedUp = val;
                  });
                },
              ),
            ),
            LabeledInput(
              title: 'Payment Confirmed?',
              input: Checkbox(
                value: _paymentConfirmed,
                onChanged: (val) {
                  setState(() {
                    _paymentConfirmed = val;
                  });
                },
              ),
            ),
            RaisedButton(
              child: Text('Done'),
              onPressed: () {
                _update();
                _submit();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _update();
  }
}
