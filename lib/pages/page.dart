import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

abstract class PageState<Page extends StatefulWidget> extends State<Page> {
  bool _loading = false;

  GlobalKey scaffoldKey = GlobalKey();

  void startLoading() {
    setState(() => _loading = true);
  }

  void stopLoading() {
    setState(() => _loading = false);
  }

  PreferredSizeWidget buildAppBar(BuildContext context);

  Widget buildBody(BuildContext context);

  void update() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: buildAppBar(context),
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: buildBody(context),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    update();
  }
}
