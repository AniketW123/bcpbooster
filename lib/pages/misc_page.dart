import 'package:flutter/material.dart';
import 'page.dart';
import '../constants.dart';
import '../sheet_row.dart';
import '../util/buttons.dart';
import '../util/inputs.dart';

class MiscPage extends StatefulWidget {
  @override
  _MiscPageState createState() => _MiscPageState();
}

class _MiscPageState extends PageState<MiscPage> {
  bool _capPickedUp = sheetRow.capPickedUp;
  bool _jacketPickedUp = sheetRow.jacketPickedUp;
  bool _paymentConfirmed = sheetRow.paymentConfirmed;
  bool _boardInterest = sheetRow.boardInterest;
  bool _volunteerInterest = sheetRow.volunteerInterest;

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
      actions: [icon],
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(15.0),
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
          title: 'Are you interested in volunteering at Bellarmine events?',
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
          state: this,
          done: true
        ),
      ],
    );
  }
}
