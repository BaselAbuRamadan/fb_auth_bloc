import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fb_auth_bloc/models/custom_error.dart';


void errorDialog(BuildContext context , CustomError e){
  print ('code ${e.code}\nmessage: ${e.message}\nplugin : ${e.plugin}\n');
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CupertinoAlertDialog(
          title:  Text(e.code),
          content: Text(e.plugin +'\n' + e.message),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  } else {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(e.code),
          content: Text(e.plugin +'\n' + e.message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }


}
