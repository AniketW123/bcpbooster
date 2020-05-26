import 'package:flutter/material.dart';
import 'page.dart';
import 'misc_page.dart';
import '../constants.dart';
import '../sheet_row.dart';
import '../util/buttons.dart';
import '../util/inputs.dart';

class MembershipPage extends StatefulWidget {
  @override
  _MembershipPageState createState() => _MembershipPageState();
}

class _MembershipPageState extends PageState<MembershipPage> {
  Map<String, String> _radioInputs = {
    'membershipType': sheetRow.membershipType,
    'jacketStyle': sheetRow.jacketStyle,
    'jacketSize': sheetRow.jacketSize,
    'sportsFormat': sheetRow.sportsFormat,
  };

  Widget _radioGroup({List<String> titles, @required List<String> values, @required String name, bool column = false}) {
    if (titles == null) {
      titles = values;
    } else {
      assert(titles.length == values.length);
    }

    List<Widget> list = [];
    for (int i = 0; i < titles.length; i++) {
      list.add(Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: LabeledInput(
          title: titles[i],
          isChoice: true,
          input: Radio(
            value: values[i],
            groupValue: _radioInputs[name],
            onChanged: (val) {
              setState(() {
                _radioInputs[name] = val;
              });
            },
          ),
        ),
      ));
    }

    return column ? Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: list,
    ) : Expanded(
      child: Wrap(
        alignment: WrapAlignment.end,
        children: list,
      ),
    );
  }

  @override
  void update() {
    sheetRow.membershipType = _radioInputs['membershipType'];
    sheetRow.jacketStyle = _radioInputs['jacketStyle'];
    sheetRow.jacketSize = _radioInputs['jacketSize'];
    sheetRow.sportsFormat = _radioInputs['sportsFormat'];
  }

  @override
  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Membership Details'),
      actions: [icon],
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(15.0),
      children: <Widget>[
        LabeledInput(
          title: 'Membership Type',
          input: _radioGroup(
            name: 'membershipType',
            column: true,
            titles: ['Premium 4 Year - \$500', 'Deluxe Family - \$225', 'Basic Family - \$130', 'Young Alumni - \$50', 'Contact Info Only'],
            values: ['Premium 4 Year', 'Deluxe Family', 'Basic Family', 'Young Alumni', 'Contact Info Only'],
          ),
        ),
        Visibility(
          visible: _radioInputs['membershipType'] != 'Contact Info Only',
          child: LabeledInput(
            title: 'Jacket Style',
            input: _radioGroup(
              name: 'jacketStyle',
              values: ['Male', 'Female'],
            ),
          ),
        ),
        Visibility(
          visible: _radioInputs['membershipType'] != 'Contact Info Only',
          child: LabeledInput(
            title: 'Jacket Size',
            input: _radioGroup(
              name: 'jacketSize',
              values: ['S', 'M', 'L', 'XL', 'XXL', 'XXXL']
            ),
          ),
        ),
        Visibility(
          visible: _radioInputs['membershipType'] != 'Contact Info Only',
          child: LabeledInput(
            title: 'Sports Program Format',
            input: _radioGroup(
              name: 'sportsFormat',
              values: ['Digital', 'Printed']
            ),
          ),
        ),
        SubmitButton(
          state: this,
          done: _radioInputs['membershipType'] == 'Contact Info Only',
          routeBuilder: (_) => MiscPage(),
        ),
      ],
    );
  }
}
