import 'package:flutter/material.dart';
import 'package:oystars_flutter_app/constants/colors.dart';

const snackBarDurationSeconds = 3;

showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: snackBarDurationSeconds),
  ));
}

// shows a loading spinner while a future executes and dismisses it when it is done
Future<dynamic> showLoadingSpinner(
    BuildContext context, Future<dynamic> future) async {
  BuildContext dialogContext = context;
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        dialogContext = context;
        return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              alignment: Alignment.center,
              width: 100,
              height: 100,
              child: CircularProgressIndicator(),
            ));
      });

  var result = await future;
  Navigator.of(context).pop(dialogContext);
  return result;
}
