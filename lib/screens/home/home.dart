import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petto/core/models/user_model.dart';
import 'package:petto/core/services/user_db_service.dart';
import 'package:provider/provider.dart';

import '../../core/widget/behavior.dart';
import '../appointment/list_appointment.dart';
import '../vet_care/add_vet_care.dart';
import '../vet_care/list_vet_care.dart';
import 'profile.dart';

class Home extends StatelessWidget {
  const Home({
    Key? key,
    required this.uid,
  }) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context) {
    // var userData = context.read<UserDatabaseService>().checkUserData(uid);
    String defaultImage =
        "https://firebasestorage.googleapis.com/v0/b/petto-2fc47.appspot.com/o/image_user%2Fprofile.png?alt=media&token=8a3f2161-ef6c-4879-af9e-110a6b3ee789";

    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFA1A1),
                Colors.white,
              ],
            ),
          ),
          child: CustomScrollBehavior(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Profile(),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              FutureBuilder<DocumentSnapshot>(
                                future: context
                                    .read<UserDatabaseService>()
                                    .checkUserData(uid),
                                builder: (_, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return RowProfile(
                                      userPicture: snapshot.data!['picture'],
                                      userName: snapshot.data!['name'],
                                    );
                                  } else {
                                    return RowProfile(
                                      userPicture: defaultImage,
                                      userName: "User",
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Find the schedule,\nand get a professional doctor',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CardMenu(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ListAppointment(),
                              ),
                            );
                          },
                          iconAsset: 'assets/images/ic_heart.png',
                          title: "Appointments",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CardMenu(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ListVetCare(),
                              ),
                            );
                          },
                          iconAsset: 'assets/images/ic_medic.png',
                          title: "Vet Care",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CardMenu(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddVetCare(),
                              ),
                            );
                          },
                          iconAsset: 'assets/images/ic_medic.png',
                          title: "My Vet Care",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FutureBuilder<QuerySnapshot>(
                          future:
                              context.read<UserDatabaseService>().dataDoctor(),
                          builder: (_, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.data!.size > 0) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Our Top Veterinary',
                                      style: GoogleFonts.poppins(fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: snapshot.data!.docs
                                          .map(
                                            (data) => Row(
                                              children: [
                                                RowTopDoctor(
                                                  doctorImage: data['picture'],
                                                  doctorName: data['name'],
                                                ),
                                              ],
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ],
                                );
                              } else {
                                return const SizedBox();
                              }
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardMenu extends StatelessWidget {
  const CardMenu({
    Key? key,
    required this.onTap,
    required this.iconAsset,
    required this.title,
  }) : super(key: key);

  final GestureTapCallback onTap;
  final String iconAsset;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.14,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 60,
              ),
              child: Image.asset(
                iconAsset,
                width: 32,
                height: 32,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                title,
                style: GoogleFonts.roboto(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RowTopDoctor extends StatelessWidget {
  const RowTopDoctor({
    Key? key,
    required this.doctorImage,
    required this.doctorName,
  }) : super(key: key);

  final String doctorImage;
  final String doctorName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: CachedNetworkImage(
            imageUrl: doctorImage,
            placeholder: (context, url) => Container(
              color: Colors.black26,
              child: Center(
                child: SpinKitChasingDots(
                  size: 15,
                  color: Colors.red.shade900,
                ),
              ),
            ),
            errorWidget: (context, _, error) => Container(
              color: Colors.black26,
              child: Icon(
                Icons.error_outline_rounded,
                size: 25,
                color: Colors.red.shade700,
              ),
            ),
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          "Dr. $doctorName",
          style: GoogleFonts.poppins(fontSize: 16),
        ),
      ],
    );
  }
}

class RowProfile extends StatelessWidget {
  const RowProfile({
    Key? key,
    required this.userPicture,
    required this.userName,
  }) : super(key: key);

  final String userPicture;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: CachedNetworkImage(
            imageUrl: userPicture,
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
            width: 55,
            height: 55,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
          ),
          child: Text(
            "Hello, $userName",
            style: GoogleFonts.poppins(
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
