import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/services/auth_service.dart';
import '../../core/widget/behavior.dart';
import '../../core/widget/text_fied.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _ctrlEmail = TextEditingController();
  final _ctrlPassword = TextEditingController();
  final _ctrlPasswordConfirm = TextEditingController();

  final _focusNodeEmail = FocusNode();
  final _focusNodePassword = FocusNode();
  final _focusNodePasswordConfirm = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _ctrlEmail.dispose();
    _ctrlPassword.dispose();
    _ctrlPasswordConfirm.dispose();

    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _focusNodePasswordConfirm.dispose();
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
                children: const [
                  Text("Petto."),
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
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "This field is required";
                                }
                              },
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
                              canNext: true,
                              onSubmitted: (value) {
                                FocusScope.of(context).requestFocus(
                                  _focusNodePasswordConfirm,
                                );
                              },
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "This field is required";
                                } else if (val.length < 6) {
                                  return 'The password must at least 6 characters';
                                }
                              },
                            ),
                            const SizedBox(height: 30),
                            const Text(
                              "Confirm Password",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 15),
                            FieldAuth(
                              controller: _ctrlPasswordConfirm,
                              focusNode: _focusNodePasswordConfirm,
                              isPassword: true,
                              onSubmitted: (value) {
                                _focusNodePasswordConfirm.unfocus();
                              },
                              validator: (val) {
                                if (val != _ctrlPassword.text) {
                                  return "Password doesn't match";
                                }
                              },
                            ),
                            const SizedBox(height: 30),
                            GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  var register = await context
                                      .read<AuthService>()
                                      .registerWithEmailAndPassword(
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
                                  "Sign Up",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),
                            GestureDetector(
                              onTap: () {
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                } else {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Login(),
                                    ),
                                  );
                                }
                              },
                              child: const Center(
                                child: Text(
                                  "Already Have Account?",
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
