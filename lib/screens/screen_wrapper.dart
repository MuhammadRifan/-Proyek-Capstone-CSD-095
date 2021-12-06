import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/widget/flushbar.dart';
import 'auth/login.dart';
import 'home/home.dart';

class ScreenWrapper extends StatelessWidget {
  const ScreenWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();

    if (user != null) {
      log("cek " + user.toString());
      if (!user.emailVerified) {
        Future<void>.delayed(Duration.zero, () {
          Alert.info(
            context: context,
            msg: "Please check your email or try to log in",
          );
        });
        return const Login();
      } else {
        Future<void>.delayed(Duration.zero, () {
          Alert.success(
            context: context,
            msg: "Log In Success",
          );
        });
        return const Home();
      }
    } else {
      log("cek null");
      return const Login();
    }
  }
}
