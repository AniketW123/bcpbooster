import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'page.dart';
import 'util/alert.dart';
import 'util/inputs.dart';
import '../constants.dart';
import '../sheet_row.dart';

class MiscPage extends StatefulWidget {
  static const String path = '/misc';

  @override
  _MiscPageState createState() => _MiscPageState();
}

class _MiscPageState extends PageState<MiscPage> {
  bool _capPickedUp = sheetRow.capPickedUp;
  bool _jacketPickedUp = sheetRow.jacketPickedUp;
  bool _paymentConfirmed = sheetRow.paymentConfirmed;
  bool _boardInterest = sheetRow.boardInterest;
  bool _volunteerInterest = sheetRow.volunteerInterest;

  void _submit() async {
    startLoading();

    http.Response res = await http.post(
      'https://sheets.googleapis.com/v4/spreadsheets/$sheetId/values/1:1:append?valueInputOption=USER_ENTERED',
      headers: await googleSignIn.currentUser.authHeaders,
      body: jsonEncode({
        'majorDimension': 'ROWS',
        'values': [sheetRow.getList()]
      }),
    );

    stopLoading();

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
              Navigator.pushNamed(context, '/profile_info');
            },
          )
        ],
      );
    }
  }

  @override
  void update() {
    sheetRow.capPickedUp = _capPickedUp;
    sheetRow.jacketPickedUp = _jacketPickedUp;
    sheetRow.paymentConfirmed = _paymentConfirmed;
    sheetRow.boardInterest = _boardInterest;
    sheetRow.volunteerInterest = _volunteerInterest;
  }

  @override
  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Miscellaneous'),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Padding(
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
          LabeledInput(
            title: 'Are you interested in joining the Dad\'s Club board?',
            input: Checkbox(
              value: _boardInterest,
              onChanged: (val) {
                setState(() {
                  _boardInterest = val;
                });
              },
            ),
          ),
          LabeledInput(
            title: 'Are you interested in volunteering for Bellarmine events?',
            input: Checkbox(
              value: _volunteerInterest,
              onChanged: (val) {
                setState(() {
                  _volunteerInterest = val;
                });
              },
            ),
          ),
          SubmitButton(
            title: 'Done',
            onPressed: () {
              update();
              _submit();
            },
          ),
        ],
      ),
    );
  }
}
