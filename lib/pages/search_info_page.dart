import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'page.dart';
import '../constants.dart';
import '../util/buttons.dart';
import '../util/inputs.dart';

class SearchInfoPage extends StatefulWidget {
  final String name;
  final int row;

  SearchInfoPage({required this.name, required this.row});

  @override
  _SearchInfoPageState createState() => _SearchInfoPageState();
}

const int jacketIndex = 8;
const int capIndex = 9;

class _SearchInfoPageState extends PageState<SearchInfoPage> {
  List<dynamic>? row;

  void _getRow() async {
    startLoading();

    http.Response res = await http.get(
      Uri.parse('https://sheets.googleapis.com/v4/spreadsheets/$searchSheetId/values/${widget.row}:${widget.row}'),
      headers: await googleSignIn.currentUser!.authHeaders,
    );
    row = jsonDecode(res.body)['values'][0];

    stopLoading();
  }

  void _save() async {
    startLoading();

    http.Response res = await http.put(
      Uri.parse('https://sheets.googleapis.com/v4/spreadsheets/$searchSheetId/values/${widget.row}:${widget.row}?valueInputOption=USER_ENTERED'),
      headers: await googleSignIn.currentUser!.authHeaders,
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

  Widget _radioGroup({required List<String> values, required String groupValue, required ValueChanged<String?> onChanged}) {
    List<Widget> list = [];
    for (int i = 0; i < values.length; i++) {
      list.add(Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: LabeledInput(
          title: values[i],
          isChoice: true,
          input: Radio(
            value: values[i],
            groupValue: groupValue,
            onChanged: onChanged,
          ),
        ),
      ));
    }

    return Expanded(
      child: Wrap(
        alignment: WrapAlignment.end,
        children: list,
      ),
    );
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
          title: 'Membership',
          input: Padding(
            padding: EdgeInsets.symmetric(vertical: 14.0),
            child: Text(
              row![5],
              style: inputStyle,
            ),
          ),
        ),
        if (row![5] != 'Contact Info Only') ...[
          LabeledInput(
            title: 'Jacket Style',
            input: _radioGroup(
                values: ['Male', 'Female'],
                groupValue: row![6],
                onChanged: (val) {
                  setState(() {
                    row![6] = val;
                  });
                }
            ),
          ),
          LabeledInput(
            title: 'Jacket Size',
            input: _radioGroup(
              values: ['S', 'M', 'L', 'XL', 'XXL', 'XXXL'],
              groupValue: row![7],
              onChanged: (val) {
                setState(() {
                  row![7] = val;
                });
              }
            ),
          ),
          LabeledInput(
            title: 'Jacket picked up?',
            input: Checkbox(
              value: row![jacketIndex] == 'YES',
              onChanged: (val) {
                setState(() {
                  row![jacketIndex] = val! ? 'YES' : 'NO';
                });
              },
            ),
          ),
          LabeledInput(
            title: 'Cap picked up?',
            input: Checkbox(
              value: row![capIndex] == 'YES',
              onChanged: (val) {
                setState(() {
                  row![capIndex] = val! ? 'YES' : 'NO';
                });
              },
            ),
          ),
          PrimaryButton(
            text: 'Save',
            onPressed: _save,
          ),
        ],
      ],
    );
  }
}
