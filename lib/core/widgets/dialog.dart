import 'dart:developer';

import 'package:flutter/material.dart';

///custom [Dialog] widget for the application
abstract class CustomDialog {
  void showDialog(BuildContext? context,
      {AlignmentGeometry position = Alignment.center}) {
    if (context == null) {
      log("Build context is null try to add 'ScreenScaffold' or Use proper 'buildContext'");
      return;
    }
    showGeneralDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return WillPopScope(
          onWillPop: () async => false,
          child: SlideTransition(
            position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
                .animate(a1),
            child: FadeTransition(
              opacity: a1,
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                child: getChild(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getChild();

  void show();
}
