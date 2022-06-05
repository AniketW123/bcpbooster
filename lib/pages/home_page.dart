import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'page.dart';
import 'sign_in_page.dart';
import 'start_page.dart';
import '../constants.dart';
import '../util/alert.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends PageState<HomePage> {
  List<bool> expanded = [false, false, false];

  void _getSheet() async {
    startLoading();

    http.Response res = await http.get(
      'https://sheets.googleapis.com/v4/spreadsheets/$sheetId',
      headers: await googleSignIn.currentUser.authHeaders,
    );

    stopLoading();

    if (res.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => StartPage(),
          settings: RouteSettings(name: '/start')
        ),
      );
    } else {
      String errorMessage = res.statusCode == 403
          ? 'Unfortunately, this account does not have access to the signups spreadsheet (Error 403). Please sign in with a different account or contact $accessEmail to get access.'
          : 'Error ${res.statusCode}. Try again.';

      alert(
        context: context,
        title: 'Error!',
        message: Text(errorMessage),
        actions: <Widget>[
          AlertButton(
            'OK',
            onPressed: () async {
              await googleSignIn.disconnect();
              Navigator.pop(context);
            },
          ),
        ],
      );
    }
  }

  void _userChanged(GoogleSignInAccount account) {
    if (account?.id != null) {
      _getSheet();
    } else {
      googleSignIn.signOut();
      Navigator.popUntil(context, (route) => route.isFirst);
    }
  }

  Widget _bodyText(List<String> text) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        text.join(' '),
        style: TextStyle(
          fontSize: 18.0
        ),
      ),
    );
  }
  
  Widget _link(String text, {String url}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: GestureDetector(
        child: Text(
          text,
          style: TextStyle(
            decoration: TextDecoration.underline
          ),
        ),
        onTap: () {
          launch(url);
        },
      ),
    );
  }

  Widget Function(BuildContext, bool) _expansionHeaderBuilder(String title) {
    return (_, isExpanded) => Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  @override
  void initState() {
    googleSignIn.onCurrentUserChanged.listen(_userChanged);
    googleSignIn.signInSilently();
    super.initState();
  }

  @override
  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text('BCP Booster Club'),
      actions: [
        TextButton(
          child: Text(
            'Login',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SignInPage()),
            );
          },
        ),
        icon,
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Scrollbar(
          child: Padding(
            padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 30.0),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 50.0),
                  child: Text(
                    'A center for managing members for Bellarmine College Prep\'s Booster Club Program, organized by the Dad\'s Club.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0
                    ),
                  ),
                ),
                ExpansionPanelList(
                  expandedHeaderPadding: EdgeInsets.zero,
                  children: [
                    ExpansionPanel(
                      isExpanded: expanded[0],
                      headerBuilder: _expansionHeaderBuilder('What is the Booster Club?'),
                      body: _bodyText([
                        'Bellarmine Boosters provides financial support to the school\'s athletics program.',
                        'Funds raised through the Booster Club benefit Bellarmine\'s annual athletics budget and assist in funding school projects through which student athletes benefit.',
                      ]),
                    ),
                    ExpansionPanel(
                      isExpanded: expanded[1],
                      headerBuilder: _expansionHeaderBuilder('What is the Dad\'s Club?'),
                      body: _bodyText([
                        'The Bellarmine Dad\'s Club is a volunteer organization that provides opportunities for fathers to bond with their sons while modeling what it means to be “Men for and with Others.”',
                        'Through event and program leadership, direct volunteering, fundraising, and sponsorship, we support campus events, community outreach projects, student mentoring and athletic programs.',
                        'The Dads’ Club is composed of all Bellarmine dads and is led by the 40-member Dad\'s Club Board.',
                      ]),
                    ),
                    ExpansionPanel(
                      isExpanded: expanded[2],
                      headerBuilder: _expansionHeaderBuilder('Using this website'),
                      body: _bodyText([
                        'Parent volunteers that are authorized by the Dad’s Club Board can use the above login button to authenticate and help add/manage Booster Club members.',
                        'Authentication using your Google account is purely needed to access the central spreadsheet (this website won\'t access any of your Gmail or Google Drive data).',
                        'Once logged in, you will have the option to either search for existing members or add a new member.',
                      ]),
                    ),
                  ],
                  expansionCallback: (index, isExpanded) {
                    setState(() {
                      expanded[index] = !isExpanded;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0.0,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
            child: Row(
              children: [
                _link(
                  'Privacy Policy',
                  url: 'https://booster.belldcb.com/privacy',
                ),
                _link(
                  'Contact Us',
                  url: 'mailto:bcp-dads-club-board@googlegroups.com',
                ),
                _link(
                  'Feedback',
                  url: 'mailto:shaunak.warty@gmail.com?subject=BCP Booster Club Website Feedback',
                ),
              ],
            )
          ),
        )
      ],
    );
  }
}
