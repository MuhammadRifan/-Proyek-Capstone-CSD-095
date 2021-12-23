import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:petto/core/services/auth_service.dart';
import 'package:petto/core/services/user_db_service.dart';
import 'package:petto/core/widget/flushbar.dart';
import 'package:petto/screens/appointment/list_appointment.dart';
import 'package:petto/screens/home/edit_profile.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Icon(
                      Icons.segment_sharp,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/userpic.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100.0),
                  ),
                  border: Border.all(
                    color: Colors.white,
                    width: 4.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 4,
                      offset: const Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: const [
                  Text('UserName'),
                  Text('Email'),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                  child: const Divider(
                    color: Colors.white,
                    thickness: 4,
                    indent: 5,
                    endIndent: 5,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfile(),
                          ),
                        );
                      },
                      child: const ProfileWidget(
                        text: 'Edit Profile',
                        icon: Icons.settings,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 10),
                        child: const Divider(
                          color: Colors.white,
                          thickness: 4,
                          indent: 5,
                          endIndent: 5,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () async {
                        await context.read<AuthService>().signOut();

                        Navigator.pop(context);

                        Alert.success(
                          context: context,
                          msg: "Log out success",
                        );
                      },
                      child: const ProfileWidget(
                        text: 'Log Out',
                        icon: Icons.logout_outlined,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileActivity extends StatelessWidget {
  const ProfileActivity({
    Key? key,
    required this.number,
    required this.text,
  }) : super(key: key);

  final String number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(number),
        Text(text),
      ],
    );
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        Text(text),
        const Icon(
          Icons.keyboard_arrow_right,
          color: Colors.white,
        ),
      ],
    );
  }
}
