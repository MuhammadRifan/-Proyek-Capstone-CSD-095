import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../core/helper/string_helper.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/user_db_service.dart';
import '../../core/widget/flushbar.dart';
import 'edit_profile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var user = context.read<AuthService>().userData;

    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              "Profile",
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          FutureBuilder<DocumentSnapshot>(
            future: context.read<UserDatabaseService>().checkUserData(
                  user!.uid,
                ),
            builder: (_, snapshot) {
              var userName = "username";
              var image = StringHelper.defaultUser;

              if (snapshot.connectionState == ConnectionState.done) {
                userName = snapshot.data!['name'];
                image = snapshot.data!['picture'];
              }

              return SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: const Color(0xff7c94b6),
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
                            offset: const Offset(
                              0,
                              5,
                            ),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: image,
                          placeholder: (context, url) => Container(
                            color: Colors.black26,
                            child: Center(
                              child: SpinKitChasingDots(
                                size: 20,
                                color: Colors.red.shade900,
                              ),
                            ),
                          ),
                          errorWidget: (context, _, error) => Container(
                            color: Colors.black26,
                            child: Icon(
                              Icons.error_outline_rounded,
                              size: 30,
                              color: Colors.red.shade700,
                            ),
                          ),
                          fit: BoxFit.cover,
                          // width: 190,
                          // height: 190,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          user.email!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
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
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const AddUserData(),
                              //   ),
                              // );
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
                              margin: const EdgeInsets.only(
                                top: 20,
                                bottom: 10,
                              ),
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
              );
            },
          ),
        ],
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
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const Icon(
          Icons.keyboard_arrow_right,
          color: Colors.white,
        ),
      ],
    );
  }
}
