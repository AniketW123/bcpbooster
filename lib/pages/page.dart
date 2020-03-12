import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

abstract class PageState<Page extends StatefulWidget> extends State<Page> {
  bool _loading = false;

  PreferredSizeWidget buildAppBar(BuildContext context);

  Widget buildBody(BuildContext context);

  void startLoading() {
    setState(() => _loading = true);
  }

  void stopLoading() {
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: SingleChildScrollView(
          child: buildBody(context),
        ),
      ),
    );
  }
}
