import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:traqq/widgets/simple_text.dart';
class ToastMessage {
  static showErrorMessage(BuildContext context,String message) {
    FToast().init(context);
    FToast().showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            SimpleText(text: message,color: Theme.of(context).colorScheme.onPrimaryContainer,),
          ],
        ),
      ),
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 2),
    );
  }
}
