import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'page.dart';
import '../constants.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends PageState<SignInPage> {
  @override
  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Sign In'),
      actions: [icon],
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50.0, bottom: 20.0),
            child: Text(
              'Volunteer Login',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
          GoogleSignInButton(
            onPressed: googleSignIn.signIn,
          ),
        ],
      ),
    );
  }
}
