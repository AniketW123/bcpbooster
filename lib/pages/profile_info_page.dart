import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'page.dart';
import 'util/alert.dart';
import 'util/inputs.dart';
import '../constants.dart';
import '../sheet_row.dart';
import './membership_page.dart';

const List<String> _states = ['AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA',
                              'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD',
                              'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ',
                              'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC',
                              'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY'];

class ProfileInfoPage extends StatefulWidget {
  static const String path = '/profile_info';

  @override
  _ProfileInfoPageState createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends PageState<ProfileInfoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _state = 'CA';

  String _validator(String val) {
    if (val.length == 0) {
      return 'Must contain text.';
    }
    return null;
  }

  @override
  void update() {
    sheetRow.state = _state;
  }

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
            FormPadding(
              child: TextFormField(
                cursorColor: primaryColor,
                style: inputStyle,
                textCapitalization: TextCapitalization.words,
                validator: _validator,
                decoration: InputDecoration(
                  labelText: 'First name',
                ),
                onChanged: (val) {
                  sheetRow.firstName = val;
                },
              ),
            ),
            FormPadding(
              child: TextFormField(
                cursorColor: primaryColor,
                style: inputStyle,
                textCapitalization: TextCapitalization.words,
                validator: _validator,
                decoration: InputDecoration(
                  labelText: 'Last name',
                ),
                onChanged: (val) {
                  sheetRow.lastName = val;
                },
              ),
            ),
            FormPadding(
              child: TextFormField(
                cursorColor: primaryColor,
                keyboardType: TextInputType.emailAddress,
                style: inputStyle,
                validator: (val) => EmailValidator.validate(val, true) ? null : 'Not a valid email.',
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                onChanged: (val) {
                  sheetRow.email = val;
                },
              ),
            ),
            FormPadding(
              child: NumberTextField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                ),
                maxLength: 10,
                onChanged: (val) {
                  sheetRow.phoneNum = val;
                },
              ),
            ),
            FormPadding(
              child: TextFormField(
                cursorColor: primaryColor,
                style: inputStyle,
                textCapitalization: TextCapitalization.words,
                validator: _validator,
                decoration: InputDecoration(
                  labelText: 'Address',
                ),
                onChanged: (val) {
                  sheetRow.address = val;
                },
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FormPadding(
                  flex: 4,
                  child: TextFormField(
                    cursorColor: primaryColor,
                    style: inputStyle,
                    textCapitalization: TextCapitalization.words,
                    validator: _validator,
                    decoration: InputDecoration(
                      labelText: 'City',
                    ),
                    onChanged: (val) {
                      sheetRow.city = val;
                    },
                  ),
                ),
                FormPadding(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(top: 18.0),
                    height: 75.0,
                    child: DropdownButton(
                      value: _state,
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: _states.map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      )).toList(),
                      isExpanded: true,
                      style: inputStyle,
                      underline: Container(
                        height: 1,
                        color: Colors.black45,
                      ),
                      onChanged: (val) {
                        setState(() {
                          _state = val;
                        });
                      },
                    ),
                  ),
                ),
                FormPadding(
                  flex: 3,
                  child: NumberTextField(
                    decoration: InputDecoration(
                      labelText: 'Zip Code',
                    ),
                    maxLength: 5,
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
                  update();
                  Navigator.pushNamed(context, MembershipPage.path);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FormPadding extends StatelessWidget {
  final int flex;
  final Widget child;

  FormPadding({this.flex, @required this.child});

  @override
  Widget build(BuildContext context) {
    Padding padding = Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      child: child,
    );

    return flex == null ? padding : Expanded(
      flex: flex,
      child: padding,
    );
  }
}

