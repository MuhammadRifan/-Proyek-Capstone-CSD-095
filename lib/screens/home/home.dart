import 'package:flutter/material.dart';
import 'package:petto/core/widget/flushbar.dart';
import 'package:provider/provider.dart';

import '../../core/services/auth_service.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () async {
            await context.read<AuthService>().signOut();
            Alert.success(
              context: context,
              msg: "Log out success",
            );
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: const Color(0xFFFE4545),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "Logout",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
