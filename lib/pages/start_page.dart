import 'package:flutter/material.dart';
import 'page.dart';
import 'search_page.dart';
import 'profile_info_page.dart';
import '../constants.dart';
import '../util/alert.dart';
import '../util/buttons.dart';
import '../util/text.dart';

class StartPage extends StatefulWidget {
  static const String path = '/start';

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends PageState<StartPage> {
  @override
  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Home'),
      leading: IconButton(
        icon: Icon(Icons.exit_to_app),
        onPressed: () {
          alert(
            context: context,
            title: 'Are you sure you want to sign out?',
            actions: <Widget>[
              AlertButton('Cancel'),
              AlertButton(
                'Sign Out',
                textColor: Colors.red.shade700,
                onPressed: googleSignIn.disconnect,
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          TitleText('Bellarmine Booster Club Signups'),
          PrimaryButton(
            text: 'Add New Member',
            onPressed: () {
              Navigator.pushNamed(context, ProfileInfoPage.path);
            },
          ),
          PrimaryButton(
            text: 'Find Member',
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.path);
            },
          ),
        ],
      ),
    );
  }
}
