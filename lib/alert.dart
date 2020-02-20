import 'package:flutter/material.dart';

void alert({@required BuildContext context, @required String title, String message, List<Widget> actions}) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
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
      child: textColor != null ? Text(
        title,
        style: TextStyle(
          color: textColor
        ),
      ) : Text(title),
      onPressed: onPressed,
    );
  }
}

