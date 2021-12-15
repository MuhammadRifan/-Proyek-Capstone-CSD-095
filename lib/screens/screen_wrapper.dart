import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petto/screens/home/home.dart';
import 'package:petto/screens/vet_care/list_vet_care.dart';
import 'package:petto/screens/pet/add_pet.dart';
import 'package:petto/screens/user/add_user_data.dart';
import 'package:provider/provider.dart';

import '../core/services/user_db_service.dart';
import '../core/widget/flushbar.dart';
import 'auth/login.dart';
import 'vet_care/list_vet_care.dart';

class ScreenWrapper extends StatelessWidget {
  const ScreenWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();

    if (user != null) {
      // log("cek " + user.toString());
      if (!user.emailVerified) {
        Future<void>.delayed(Duration.zero, () {
          Alert.info(
            context: context,
            msg: "Please check your email or try to log in",
          );
        });
        return const Login();
      } else {
        final data =
            context.read<UserDatabaseService>().checkUserData(user.uid);

        Future<void>.delayed(Duration.zero, () {
          Alert.success(
            context: context,
            msg: "Log In Success",
          );

          // context.read<UserDatabaseService>().checkUserData(user.uid).then(
          //   (DocumentSnapshot documentSnapshot) {
          //     log(documentSnapshot.data().toString());
          //     if (documentSnapshot.exists) {
          //       return Home();
          //     } else {
          //       return AddUserData();
          //     }
          //   },
          // );
        });

        // FutureBuilder<DocumentSnapshot>(
        //   future: context.read<UserDatabaseService>().checkUserData(user.uid),
        //   builder: (_, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.done) {
        //       if (snapshot.data!.exists) {
        //         return Home();
        //       } else {
        //         return AddUserData();
        //       }
        //     } else {
        //       return Login();
        //     }
        //   },
        // );

        // Future<DocumentSnapshot> cek =
        //     context.read<UserDatabaseService>().cekUserData(user.uid);
        // log(cek);
        log("message");
        return Home();
        // log(data.toString());
        // FutureBuilder<String>(
        //   future: data,
        //   builder: (_, snapshot) {
        //     if (snapshot.hasData) {}
        //     log(snapshot.data.toString());
        //     return const Home();
        //   },
        // );

      }
    } else {
      log("cek null");
      return const Login();
    }
  }

  Future getUserData(BuildContext context, String uid) async {
    return await context.read<UserDatabaseService>().checkUserData(uid);
  }
}
