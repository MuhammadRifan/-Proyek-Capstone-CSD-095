import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class Alert {
  static success({
    required BuildContext context,
    required String msg,
    Duration duration = const Duration(seconds: 3),
  }) {
    return Flushbar(
      message: msg,
      icon: const Icon(
        Icons.done,
        size: 28.0,
        color: Colors.white,
      ),
      shouldIconPulse: false,
      backgroundColor: Colors.green,
      duration: duration,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(5),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    )..show(context);
  }

  static error({
    required BuildContext context,
    required String msg,
    Duration duration = const Duration(seconds: 3),
  }) {
    return Flushbar(
      message: msg,
      icon: const Icon(
        Icons.warning_amber,
        size: 28.0,
        color: Colors.white,
      ),
      shouldIconPulse: false,
      backgroundColor: Colors.red,
      duration: duration,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(5),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    )..show(context);
  }

  static info({
    required BuildContext context,
    required String msg,
    Duration duration = const Duration(seconds: 3),
  }) {
    return Flushbar(
      message: msg,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.blue[300],
      ),
      shouldIconPulse: false,
      duration: duration,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(5),
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    )..show(context);
  }
}
