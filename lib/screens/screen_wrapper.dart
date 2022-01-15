import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/services/user_db_service.dart';
import '../core/widget/flushbar.dart';
import 'auth/login.dart';
import 'home/home.dart';
import 'user/add_user_data.dart';

class ScreenWrapper extends StatelessWidget {
  const ScreenWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();

    if (user != null) {
      log(user.toString());
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

        return FutureBuilder<DocumentSnapshot>(
          future: context.read<UserDatabaseService>().checkUserData(user.uid),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                Future<void>.delayed(Duration.zero, () {
                  Alert.error(
                    context: context,
                    msg: "Oops, something went wrong!",
                  );
                });
                return const Login();
              }

              if (snapshot.data!.exists) {
                return Home(
                  uid: user.uid,
                  jenis: snapshot.data!['jenis'],
                );
              } else {
                return AddUserData(
                  uid: user.uid,
                  first: true,
                );
              }
            } else {
              return const Login();
            }
          },
        );
      }
    } else {
      return const Login();
    }
  }
}
