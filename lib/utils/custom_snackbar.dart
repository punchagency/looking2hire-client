import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

 snackBar({
  required String title,
  required String message,
}) => SnackBar(
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.transparent,

  duration: Duration(seconds: 5),
  content: AwesomeSnackbarContent(
    title: title,
    message:
    message,

    contentType: title == "Success" ? ContentType.success : title == "Warning" ? ContentType.warning : ContentType.failure,
  ),
);

void setSnackBar({required BuildContext context, required String title, required String message})=> ScaffoldMessenger.of(context)
  ..hideCurrentSnackBar()
  ..showSnackBar(snackBar(title: title, message: message));