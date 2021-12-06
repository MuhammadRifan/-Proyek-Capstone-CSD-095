import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import 'flushbar.dart';

class ResendVerifDialog extends StatelessWidget {
  const ResendVerifDialog({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Resend Email Verification"),
      contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 5),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "An email will send to this account",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            email,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(
            thickness: 1,
            height: 20,
            color: Colors.grey.shade600,
          ),
          const Text(
            "If this isn't your email, you can log out or try to log in again.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Cancel",
            style: TextStyle(
              color: Colors.grey.shade800,
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
            await context.read<AuthService>().signOut();
            Alert.success(
              context: context,
              msg: "Log out success",
            );
          },
          child: const Text(
            "Log out",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
            await context.read<AuthService>().emailVerification();
            Alert.success(
              context: context,
              msg: "Email verification sent",
            );
          },
          child: Text(
            "Send email",
            style: TextStyle(
              color: Colors.green.shade700,
            ),
          ),
        ),
      ],
    );
  }
}
