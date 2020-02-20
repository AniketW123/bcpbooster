import 'package:flutter/material.dart';
import '../globals.dart';
import '../util/inputs.dart';

class SwagPage extends StatefulWidget {
  @override
  _SwagPageState createState() => _SwagPageState();
}

class _SwagPageState extends State<SwagPage> {
  bool _capPickedUp = false;
  bool _jacketPickedUp = false;
  bool _paymentConfirmed = false;

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
                sheetRow['capPickedUp'] = _capPickedUp ? 'YES' : 'NO';
                sheetRow['jacketPickedUp'] = _jacketPickedUp ? 'YES' : 'NO';
                sheetRow['paymentConfirmed'] = _paymentConfirmed ? 'YES' : 'NO';
              },
            ),
          ],
        ),
      ),
    );
  }
}
