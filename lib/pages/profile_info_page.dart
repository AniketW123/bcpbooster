import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'page.dart';
import 'membership_page.dart';
import '../constants.dart';
import '../sheet_row.dart';
import '../util/alert.dart';
import '../util/buttons.dart';
import '../util/inputs.dart';

const List<String> _states = ['AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA',
                              'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD',
                              'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ',
                              'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC',
                              'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY'];

final int _currYear = DateTime.now().add(Duration(days: 255)).year;
final List<String> _years = [_currYear, _currYear + 1, _currYear + 2, _currYear + 3]
    .map((e) => e.toString()).toList();

class ProfileInfoPage extends StatefulWidget {
  @override
  _ProfileInfoPageState createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends PageState<ProfileInfoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _gradYear = _years[3];
  String _state = 'CA';

  @override
  void update() {
    sheetRow.gradYear = _gradYear;
    sheetRow.state = _state;
  }

  @override
  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Profile Info'),
      leading: IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          alert(
            context: context,
            title: 'Are you sure you want to exit?',
            message: Text('If you exit, any information not submitted will be lost.'),
            actions: <Widget>[
              AlertButton('Stay'),
              AlertButton(
                'Exit',
                textColor: Colors.red.shade700,
                onPressed: () {
                  sheetRow = SheetRow();
                  Navigator.popUntil(context, ModalRoute.withName('/start'));
                },
              ),
            ],
          );
        },
      ),
      actions: [icon],
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 15.0),
        children: <Widget>[
          TextFieldPadding(
            child: WordsTextField(
              label: 'First Name',
              onChanged: (val) {
                sheetRow.firstName = val;
              },
            ),
          ),
          TextFieldPadding(
            child: WordsTextField(
              label: 'Last Name',
              onChanged: (val) {
                sheetRow.lastName = val;
              },
            ),
          ),
          TextFieldPadding(
            child: TextFormField(
              cursorColor: primaryColor,
              keyboardType: TextInputType.emailAddress,
              style: inputStyle,
              validator: (val) => EmailValidator.validate(val ?? '', true) ? null : 'Not a valid email.',
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              onChanged: (val) {
                sheetRow.email = val;
              },
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFieldPadding(
                flex: 2,
                child: NumberTextField(
                  label: 'Phone Number',
                  maxLength: 10,
                  onChanged: (val) {
                    sheetRow.phoneNum = val;
                  },
                ),
              ),
              TextFieldPadding(
                flex: 1,
                child: DropdownTextField(
                  label: 'Graduation Year',
                  value: _gradYear,
                  items: _years,
                  onChanged: (val) {
                    setState(() {
                      _gradYear = val ?? '';
                    });
                  },
                ),
              ),
            ],
          ),
          TextFieldPadding(
            child: WordsTextField(
              label: 'Address',
              onChanged: (val) {
                sheetRow.address = val;
              },
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFieldPadding(
                flex: 4,
                child: WordsTextField(
                  label: 'City',
                  onChanged: (val) {
                    sheetRow.city = val;
                  },
                ),
              ),
              TextFieldPadding(
                flex: 3,
                child: DropdownTextField(
                  label: 'State',
                  value: _state,
                  items: _states,
                  onChanged: (val) {
                    setState(() {
                      _state = val ?? '';
                    });
                  },
                ),
              ),
              TextFieldPadding(
                flex: 3,
                child: NumberTextField(
                  label: 'Zip Code',
                  maxLength: 5,
                  onChanged: (val) {
                    sheetRow.zip = val;
                  },
                ),
              ),
            ],
          ),
          SubmitButton(
            state: this,
            routeBuilder: (_) => MembershipPage(),
            condition: () => _formKey.currentState!.validate()
          ),
        ],
      ),
    );
  }
}

