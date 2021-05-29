import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

ProgressDialog buildProgressDialog(context, msg) {
  ProgressDialog pr = ProgressDialog(context);
  pr = ProgressDialog(context,
      type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
  pr.style(
      message: msg,
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
      ),
      messageTextStyle: TextStyle(color: Colors.grey));
  return pr;
}
