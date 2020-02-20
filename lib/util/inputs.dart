import 'package:flutter/material.dart';

class LabeledInput extends StatelessWidget {
  final String title;
  final Widget input;
  final bool noPadding;

  LabeledInput({@required this.title, @required this.input, this.noPadding = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: noPadding ? const EdgeInsets.all(0.0) : const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(title),
          ),
          input
        ],
      ),
    );
  }
}
