import 'package:flutter/material.dart';

void alert({@required BuildContext context, @required String title, Widget message, List<Widget> actions}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: message,
        actions: actions,
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
          color: textColor
        ),
      ),
      onPressed: onPressed,
    );
  }
}

