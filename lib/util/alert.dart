import 'package:flutter/material.dart';

void alert({@required BuildContext context, @required String title, Widget message, List<Widget> actions}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: message,
        actions: actions,
        actionsPadding: EdgeInsets.only(right: 10.0),
        buttonPadding: EdgeInsets.only(bottom: 10.0, left: 10.0),
      )
  );
}

class AlertButton extends StatelessWidget {
  final String title;
  final Color textColor;
  final VoidCallback onPressed;

  AlertButton(this.title, {this.textColor, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: textColor
        ),
      ),
      onPressed: onPressed ?? () {
        Navigator.pop(context);
      },
    );
  }
}

