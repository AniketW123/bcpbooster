import 'package:booster_signups/sheet_row.dart';
import 'package:flutter/material.dart';
import 'membership_page.dart';
import '../globals.dart';
import '../util/alert.dart';

class ProfileInfoPage extends StatefulWidget {
  @override
  _ProfileInfoPageState createState() => _ProfileInfoPageState();
}

final Map<String, TextEditingController> _controllers = {
  'firstName': TextEditingController(),
  'lastName': TextEditingController(),
  'email': TextEditingController(),
  'phoneNum': TextEditingController(),
  'address': TextEditingController(),
  'city': TextEditingController(),
  'state': TextEditingController(),
  'zip': TextEditingController(),
};

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Info'),
        leading: FlatButton(
          child: Icon(
            Icons.exit_to_app,
            color: Colors.white,
          ),
          onPressed: () {
            alert(
              context: context,
              title: 'Are you sure you want to sign out?',
              message: 'If you sign out, any information not saved will be lost.',
              actions: <Widget>[
                AlertButton(
                  'Cancel',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                AlertButton(
                  'Sign Out',
                  textColor: Colors.red.shade700,
                  onPressed: () {
                    sheetRow = SheetRow();
                    googleSignIn.disconnect().then((_) => Navigator.popUntil(context, (route) => route.isFirst));
                  },
                ),
              ],
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _FormField(
                label: 'First name',
                controller: 'firstName',
              ),
              _FormField(
                label: 'Last name',
                controller: 'lastName',
              ),
              _FormField(
                label: 'Email',
                controller: 'email',
                keyboardType: TextInputType.emailAddress,
              ),
              _FormField(
                label: 'Phone number',
                controller: 'phoneNum',
                keyboardType: TextInputType.phone,
              ),
              _FormField(
                label: 'Address',
                controller: 'address',
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: _FormField(
                      label: 'City',
                      controller: 'city',
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: _FormField(
                      label: 'State',
                      controller: 'state',
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: _FormField(
                      label: 'Zip code',
                      controller: 'zip',
                      keyboardType: TextInputType.number,
                    ),
                  )
                ],
              ),
              RaisedButton(
                child: Text('Next'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    sheetRow.firstName = _controllers['firstName'].text;
                    sheetRow.lastName = _controllers['lastName'].text;
                    sheetRow.email = _controllers['email'].text;
                    sheetRow.phoneNum = _controllers['phoneNum'].text;
                    sheetRow.address = _controllers['address'].text;
                    sheetRow.city = _controllers['city'].text;
                    sheetRow.state = _controllers['state'].text;
                    sheetRow.zip = _controllers['zip'].text;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MembershipPage()),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final String label;
  final String controller;
  final TextInputType keyboardType;

  _FormField({@required this.label, @required this.controller, this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        controller: _controllers[controller],
        keyboardType: keyboardType,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }
}
