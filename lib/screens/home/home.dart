import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/widget/behavior.dart';
import '../pet/add_pet.dart';
import '../vet_care/list_vet_care.dart';
import 'profile.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // bottom: false,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/setbg.png',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            CustomScrollBehavior(
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
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/userpic.png',
                                width: 52,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  "Hallo,Wong",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
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
                          SizedBox(
                            height: 20,
                          ),
                          Card(
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CupertinoSearchTextField(),
                              ],
                            ),
                          ),
                          Text(
                            'Browse by Category',
                            style: GoogleFonts.poppins(fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: (){

                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 111,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 60),
                                    child: Image.asset(
                                      'assets/images/ic_heart.png',
                                      width: 32,
                                      height: 32,
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20
                                      ),
                                      child: Text('Pet data',
                                      style: GoogleFonts.roboto(fontSize: 18) ,)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: (){

                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 111,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 60),
                                    child: Image.asset(
                                      'assets/images/ic_medic.png',
                                      width: 32,
                                      height: 32,
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20
                                      ),
                                      child: Text('Vet Care',
                                      style: GoogleFonts.roboto(fontSize: 18) ,)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Our top Veterinary',
                            style: GoogleFonts.poppins(fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/dc_pic.png',
                                    width: 52,
                                    height: 52,
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Drh.Prabowo',
                                        style:
                                            GoogleFonts.poppins(fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        'Cat Specialist',
                                        style: GoogleFonts.poppins(
                                          fontSize: 10,
                                          color: Colors.grey,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/dc_pic2.png',
                                    width: 52,
                                    height: 52,
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Drh.Camilla',
                                        style:
                                            GoogleFonts.poppins(fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        'Dog Specialist',
                                        style: GoogleFonts.poppins(
                                          fontSize: 10,
                                          color: Colors.grey,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/dc_pic2.png',
                                    width: 52,
                                    height: 52,
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Drh.Mirza',
                                        style:
                                        GoogleFonts.poppins(fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        'eye Specialist',
                                        style: GoogleFonts.poppins(
                                          fontSize: 10,
                                          color: Colors.grey,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ))
            ],
          )
          ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: (){

              },
              child: Image.asset(
                'assets/images/ic_notif.png',
                width: 24,
                height: 24,
              ),
            ),
            GestureDetector(
              onTap: (){

              },
              child: Image.asset(
                'assets/images/ic_home.png',
                width: 24,
                height: 24,
              ),
            ),
            GestureDetector(
              onTap: (){

              },
              child: Image.asset(
                'assets/images/ic_profile.png',
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
