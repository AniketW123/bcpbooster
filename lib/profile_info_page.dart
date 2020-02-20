import 'package:flutter/material.dart';
import 'alert.dart';
import 'globals.dart';

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
          child: Icon(Icons.exit_to_app, color: Colors.white,),
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
                    googleSignIn.disconnect().then((_) => Navigator.popUntil(context, (route) => route.isFirst));
                  },
                ),
              ]
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
              DefaultTextField(
                label: 'First name',
                controller: 'firstName',
              ),
              DefaultTextField(
                label: 'Last name',
                controller: 'lastName',
              ),
              DefaultTextField(
                label: 'Email',
                controller: 'email',
                keyboardType: TextInputType.emailAddress,
              ),
              DefaultTextField(
                label: 'Phone number',
                controller: 'phoneNum',
                keyboardType: TextInputType.phone,
              ),
              DefaultTextField(
                label: 'Address',
                controller: 'address',
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: DefaultTextField(
                      label: 'City',
                      controller: 'city',
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: DefaultTextField(
                      label: 'State',
                      controller: 'state',
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: DefaultTextField(
                      label: 'Zip code',
                      controller: 'zip',
                    ),
                  )
                ],
              ),
              RaisedButton(
                child: Text('Next'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    for (String controller in _controllers.keys) {
                      sheetRow[controller] = _controllers[controller].text;
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DefaultTextField extends StatelessWidget {
  final String label;
  final String controller;
  final TextInputType keyboardType;

  DefaultTextField({@required this.label, @required this.controller, this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        controller: _controllers[controller],
        keyboardType: keyboardType,
        validator: (value)  {
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

