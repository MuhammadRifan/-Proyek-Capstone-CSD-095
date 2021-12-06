import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:petto/core/widget/dialog.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/services/auth_service.dart';
import '../../core/widget/behavior.dart';
import '../../core/widget/flushbar.dart';
import '../../core/widget/text_fied.dart';
import 'register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _ctrlEmail = TextEditingController();
  final _ctrlPassword = TextEditingController();

  final _focusNodeEmail = FocusNode();
  final _focusNodePassword = FocusNode();

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  void dispose() {
    _ctrlEmail.dispose();
    _ctrlPassword.dispose();

    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              'images/header.png',
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            CustomScrollBehavior(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: 25,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Petto.",
                                style: GoogleFonts.ribeyeMarrow(
                                  fontSize: 35,
                                  color: Colors.white,
                                ),
                              ),
                              Image.asset(
                                'images/pets.png',
                                width: 45,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Sign In",
                            style: GoogleFonts.roboto(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.15,
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Email",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 15),
                              FieldAuth(
                                controller: _ctrlEmail,
                                focusNode: _focusNodeEmail,
                                canNext: true,
                                onSubmitted: (value) {
                                  FocusScope.of(context).requestFocus(
                                    _focusNodePassword,
                                  );
                                },
                                validator: (val) => (val!.isEmpty)
                                    ? "This field is required"
                                    : null,
                              ),
                              const SizedBox(height: 30),
                              const Text(
                                "Password",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 15),
                              FieldAuth(
                                controller: _ctrlPassword,
                                focusNode: _focusNodePassword,
                                isPassword: true,
                                onSubmitted: (value) {
                                  _focusNodePassword.unfocus();
                                },
                                validator: (val) => (val!.isEmpty)
                                    ? "This field is required"
                                    : null,
                              ),
                              const SizedBox(height: 30),
                              GestureDetector(
                                onTap: () async {
                                  clearFocus();

                                  if (_formKey.currentState!.validate()) {
                                    setState(() => loading = true);

                                    var register = await context
                                        .read<AuthService>()
                                        .signInWithEmailAndPassword(
                                          _ctrlEmail.text,
                                          _ctrlPassword.text,
                                        );

                                    if (register.runtimeType != User) {
                                      Alert.error(
                                        context: context,
                                        msg: register.toString(),
                                      );
                                    }
                                    setState(() => loading = false);
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFE4545),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: (loading)
                                      ? const SpinKitChasingDots(
                                          color: Colors.white,
                                          size: 25,
                                        )
                                      : const Text(
                                          "Log In",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              GestureDetector(
                                onTap: () async {
                                  clearFocus();
                                  await context
                                      .read<AuthService>()
                                      .signInWithGoogle();
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE7E3E3),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'images/google.png',
                                        width: 23,
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        "Sign In with Google",
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25),
                              GestureDetector(
                                onTap: () {
                                  clearFocus();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Register(),
                                    ),
                                  );
                                },
                                child: const Center(
                                  child: Text(
                                    "Create New Account",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Color(0xFF9A9999),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  clearFocus();
                                  final user = context.read<User?>();

                                  if (user == null) {
                                    Alert.info(
                                      context: context,
                                      msg: "Please log into your account",
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) => ResendVerifDialog(
                                        email: user.email!,
                                      ),
                                    );
                                  }
                                },
                                child: const Center(
                                  child: Text(
                                    "Resend Email Verification",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Color(0xFF9A9999),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void clearFocus() {
    _focusNodeEmail.unfocus();
    _focusNodePassword.unfocus();
  }
}
