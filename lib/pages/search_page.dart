import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'page.dart';
import '../constants.dart';
import '../util/alert.dart';
import '../util/buttons.dart';
import '../util/inputs.dart';

class SearchPage extends StatefulWidget {
  static const String path = '/search';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends PageState<SearchPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _firstName = '';
  String _lastName = '';

  void _search() async {
    startLoading();

    http.Response res = await http.get(
      'https://sheets.googleapis.com/v4/spreadsheets/$sheetId/values/C2:D',
      headers: await googleSignIn.currentUser.authHeaders,
    );

    stopLoading();

    for (List<dynamic> name in jsonDecode(res.body)['values']) {
      if (name[0].toLowerCase() == _firstName.toLowerCase() && name[1].toLowerCase() == _lastName.toLowerCase()) {
        alert(
          context: context,
          title: 'Match Found',
          message: Text('${name.join(' ')} is a Booster Club Member'),
          actions: <Widget>[
            AlertButton(
              'OK',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
        return;
      }
    }

    alert(
      context: context,
      title: 'No Match Found',
      message: Text('$_firstName $_lastName is not a Booster Club Member'),
      actions: <Widget>[
        AlertButton(
          'OK',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Member Search'),
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
            TextFieldPadding(
              child: WordsTextField(
                label: 'First Name',
                onChanged: (val) {
                  setState(() {
                    _firstName = val;
                  });
                },
              ),
            ),
            TextFieldPadding(
              child: WordsTextField(
                label: 'Last Name',
                onChanged: (val) {
                  setState(() {
                    _lastName = val;
                  });
                },
              ),
            ),
            PrimaryButton(
              text: 'Search',
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _search();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
