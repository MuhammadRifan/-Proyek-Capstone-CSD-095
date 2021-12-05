import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/services/auth_service.dart';
import '../../core/widget/behavior.dart';
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
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3.5,
              color: const Color(0xFFFE4545),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Petto."),
                      Image.asset('images/pets.png',
                          width: 40,
                          height: 54),
                    ],
                  ),


                  Text("Sign In"),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Card(
                elevation: 5,
                child: CustomScrollBehavior(
                  child: SingleChildScrollView(
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
                                if (_formKey.currentState!.validate()) {
                                  var register = await context
                                      .read<AuthService>()
                                      .signInWithEmailAndPassword(
                                        _ctrlEmail.text,
                                        _ctrlPassword.text,
                                      );

                                  if (register.runtimeType == User) {
                                    log("true" + register.toString());
                                  } else {
                                    log(register.toString());
                                  }
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(11),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFE4545),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  "Log In",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(11),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE7E3E3),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:  [
                                    Image.asset('images/google.png',
                                    width: 25,
                                    height: 23),
                                    Text(
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
