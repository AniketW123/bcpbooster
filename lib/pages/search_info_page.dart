import 'dart:convert';
import 'package:bcpbooster/util/buttons.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'page.dart';
import '../constants.dart';
import '../util/inputs.dart';

class SearchInfoPage extends StatefulWidget {
  final String name;
  final int row;

  SearchInfoPage({@required this.name, @required this.row});

  @override
  _SearchInfoPageState createState() => _SearchInfoPageState();
}

const int jacketIndex = 8;
const int capIndex = 9;

class _SearchInfoPageState extends PageState<SearchInfoPage> {
  List<dynamic> row;

  void _getRow() async {
    startLoading();

    http.Response res = await http.get(
      'https://sheets.googleapis.com/v4/spreadsheets/$searchSheetId/values/${widget.row}:${widget.row}',
      headers: await googleSignIn.currentUser.authHeaders,
    );
    row = jsonDecode(res.body)['values'][0];

    stopLoading();
  }

  void _save() async {
    startLoading();

    http.Response res = await http.put(
      'https://sheets.googleapis.com/v4/spreadsheets/$searchSheetId/values/${widget.row}:${widget.row}?valueInputOption=USER_ENTERED',
      headers: await googleSignIn.currentUser.authHeaders,
      body: jsonEncode({
        'majorDimension': 'ROWS',
        'values': [row]
      }),
    );

    stopLoading();

    if (res.statusCode == 200) {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    _getRow();
    super.initState();
  }

  @override
  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(widget.name),
      actions: [icon],
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(15.0),
      children: row == null ? [] : [
        LabeledInput(
          title: 'Jacket Style',
          input: Text(
            '${row[6]} ${row[7]}',
            style: inputStyle,
          ),
        ),
        LabeledInput(
          title: 'Jacket picked up?',
          input: Checkbox(
            value: row[jacketIndex] == 'Y',
            onChanged: (val) {
              setState(() {
                row[jacketIndex] = val ? 'Y' : 'N';
              });
            },
          ),
        ),
        LabeledInput(
          title: 'Cap picked up?',
          input: Checkbox(
            value: row[capIndex] == 'Y',
            onChanged: (val) {
              setState(() {
                row[capIndex] = val ? 'Y' : 'N';
              });
            },
          ),
        ),
        PrimaryButton(
          text: 'Save',
          onPressed: _save,
        ),
      ],
    );
  }
}
