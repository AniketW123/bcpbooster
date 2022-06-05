import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'page.dart';
import 'search_info_page.dart';
import '../constants.dart';
import '../util/alert.dart';
import '../util/buttons.dart';
import '../util/inputs.dart';

final List<Widget> _alertActions = [
  AlertButton('OK'),
];

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends PageState<SearchPage> {
  String _firstName = '';
  String _lastName = '';

  void _search() async {
    if (_firstName == '' && _lastName == '') {
      alert(
        context: context,
        title: 'Nothing searched',
        message: Text('Please enter a first name or last name to search.'),
        actions: _alertActions,
      );
      return;
    }

    startLoading();

    http.Response res = await http.get(
      'https://sheets.googleapis.com/v4/spreadsheets/$searchSheetId/values/C2:D',
      headers: await googleSignIn.currentUser.authHeaders,
    );

    if (res.statusCode != 200) {
      stopLoading();
      alert(
        context: context,
        title: 'Error.',
        message: Text('Error accessing spreadsheet. Error code ${res.statusCode}.'),
        actions: _alertActions,
      );
      return;
    }

    Iterable<dynamic> names = jsonDecode(res.body)['values'];

    if (_firstName != '') {
      names = names.where((name) => name[0].toLowerCase() == _firstName.toLowerCase());
    }

    if (_lastName != '') {
      names = names.where((name) => name[1].toLowerCase() == _lastName.toLowerCase());
    }

    stopLoading();

    if (names.length > 0) {
      alert(
        context: context,
        title: 'Match Found',
        message: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('The following members match your query. Click a name to edit that person\'s status.'),
            ...List.generate(names.length, (i) {
              String name = '${names.elementAt(i)[0]} ${names.elementAt(i)[1]}';
              return TextButton(
                child: Text(name),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SearchInfoPage(name: name, row: i + 2),
                    ),
                  );
                },
              );
            }),
          ],
        ),
        actions: _alertActions,
      );
    } else {
      alert(
        context: context,
        title: 'No Match Found',
        message: Text('No members matched your query.'),
        actions: _alertActions,
      );
    }
  }

  @override
  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Member Search'),
      actions: [icon],
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 15.0),
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
          onPressed: _search,
        ),
      ],
    );
  }
}
