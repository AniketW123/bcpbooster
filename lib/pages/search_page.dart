import 'package:flutter/material.dart';
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
    if (_formKey.currentState.validate()) {

    }
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
              onPressed: _search,
            ),
          ],
        ),
      ),
    );
  }
}
