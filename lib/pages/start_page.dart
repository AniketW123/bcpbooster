import 'package:flutter/material.dart';
import 'page.dart';
import 'profile_info_page.dart';
import '../constants.dart';
import '../util/alert.dart';
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
      title: Text('Start'),
      leading: IconButton(
        icon: Icon(Icons.exit_to_app),
        onPressed: () {
          alert(
            context: context,
            title: 'Are you sure you want to sign out?',
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
    return Column(
      children: <Widget>[
        TitleText('Bellarmine Booster Club Signups'),
        RaisedButton(
          child: Text(
            'Add New Member',
            style: TextStyle(
              fontSize: 28.0,
            ),
          ),
          color: primaryColor, // Hex: 2C3872
          textColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          onPressed: () {
            Navigator.pushNamed(context, ProfileInfoPage.path);
          },
        ),
      ],
    );
  }
}
