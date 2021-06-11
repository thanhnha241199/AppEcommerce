import 'package:flutter/material.dart';

class MsgDialog {
  static void showMsgDialog(BuildContext context, String title, String msg) {
    showGeneralDialog(
      barrierLabel: "Message",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (_, __, ___) {
        return AlertDialog(
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          content: Text(msg),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop(MsgDialog);
              },
            ),
          ],
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(
              begin: Offset(0, 1),
              end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }
}
