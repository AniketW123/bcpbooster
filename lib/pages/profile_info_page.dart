import 'package:flutter/material.dart';
import 'page.dart';
import 'util/alert.dart';
import 'util/inputs.dart';
import '../constants.dart';
import '../sheet_row.dart';


class ProfileInfoPage extends StatefulWidget {
  @override
  _ProfileInfoPageState createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends PageState<ProfileInfoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Profile Info'),
      leading: IconButton(
        icon: Icon(
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
                  googleSignIn.disconnect();
                },
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 15.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _FormField(
              label: 'First name',
              initialValue: sheetRow.firstName,
              onChanged: (val) {
                sheetRow.firstName = val;
              },
            ),
            _FormField(
              label: 'Last name',
              initialValue: sheetRow.lastName,
              onChanged: (val) {
                sheetRow.lastName = val;
              },
            ),
            _FormField(
              label: 'Email',
              initialValue: sheetRow.email,
              keyboardType: TextInputType.emailAddress,
              onChanged: (val) {
                sheetRow.email = val;
              },
            ),
            _FormField(
              label: 'Phone number',
              initialValue: sheetRow.phoneNum,
              keyboardType: TextInputType.phone,
              onChanged: (val) {
                sheetRow.phoneNum = val;
              },
            ),
            _FormField(
              label: 'Address',
              initialValue: sheetRow.address,
              onChanged: (val) {
                sheetRow.address = val;
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: _FormField(
                    label: 'City',
                    initialValue: sheetRow.city,
                    onChanged: (val) {
                      sheetRow.city = val;
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: _FormField(
                    label: 'State',
                    initialValue: sheetRow.state,
                    onChanged: (val) {
                      sheetRow.state = val;
                    },
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: _FormField(
                    label: 'Zip code',
                    initialValue: sheetRow.zip,
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      sheetRow.zip = val;
                    },
                  ),
                )
              ],
            ),
            SubmitButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Navigator.pushNamed(context, '/membership');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final String label;
  final String initialValue;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;

  _FormField({@required this.label, @required this.initialValue, @required this.onChanged, this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        keyboardType: keyboardType,
        cursorColor: primaryColor,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        style: TextStyle(
          fontSize: 18.0,
        ),
        decoration: InputDecoration(
          labelText: label,
        ),
      ),
    );
  }
}
