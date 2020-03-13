import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              onChanged: (val) {
                sheetRow.firstName = val;
              },
            ),
            _FormField(
              label: 'Last name',
              onChanged: (val) {
                sheetRow.lastName = val;
              },
            ),
            _FormField(
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
              onChanged: (val) {
                sheetRow.email = val;
              },
            ),
            _FormField(
              label: 'Phone number',
              keyboardType: TextInputType.phone,
              onChanged: (val) {
                sheetRow.phoneNum = val;
              },
            ),
            _FormField(
              label: 'Address',
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
                    onChanged: (val) {
                      sheetRow.city = val;
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: _FormField(
                    label: 'State',
                    onChanged: (val) {
                      sheetRow.state = val;
                    },
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: _FormField(
                    label: 'Zip code',
                    keyboardType: TextInputType.number,
                    maxNumbers: 5,
                    onChanged: (val) {
                      sheetRow.zip = val;
                    },
                  ),
                ),
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
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final int maxNumbers;

  _FormField({@required this.label, @required this.onChanged, this.keyboardType = TextInputType.text, this.maxNumbers});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: TextFormField(
        onChanged: onChanged,
        keyboardType: keyboardType,
        maxLength: maxNumbers,
        inputFormatters: [TextInputType.number, TextInputType.phone].contains(keyboardType) ? [
          WhitelistingTextInputFormatter.digitsOnly
        ] : null,
        cursorColor: primaryColor,
        textCapitalization: TextCapitalization.words,
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
