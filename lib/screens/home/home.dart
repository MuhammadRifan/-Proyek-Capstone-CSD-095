import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/widget/behavior.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          bottom: false,
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
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
                          const SizedBox(height: 20),
                          Card(
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                CupertinoSearchTextField(),
                              ],
                            ),
                          ),
                          Text(
                            'Browse by Category',
                            style: GoogleFonts.poppins(fontSize: 16),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 5,
                            ),
                            child: Column(children: [
                              Image.asset(
                                'assets/images/btn_daftar.png',
                                width: 325,
                                fit: BoxFit.cover,
                              ),
                              Image.asset(
                                'assets/images/btn_medic.png',
                                width: 325,
                                fit: BoxFit.cover,
                              ),
                            ]),
                          ),
                          Text(
                            'Our top Veterinary',
                            style: GoogleFonts.poppins(fontSize: 16),
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
                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Drh.Prabowo',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
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
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/dc_pic2.png',
                                    width: 52,
                                    height: 52,
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Drh.Camilla',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
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
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/images/ic_notif.png',
                            width: 24,
                            height: 24,
                          ),
                          Image.asset(
                            'assets/images/ic_home.png',
                            width: 24,
                            height: 24,
                          ),
                          Image.asset(
                            'assets/images/ic_profile.png',
                            width: 24,
                            height: 24,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ))
            ],
          )

          // child: GestureDetector(
          //   onTap: () async {
          //     await context.read<AuthService>().signOut();
          //     Alert.success(
          //       context: context,
          //       msg: "Log out success",
          //     );
          //   },
          //   child: Container(
          //     width: double.infinity,
          //     padding: const EdgeInsets.all(11),
          //     decoration: BoxDecoration(
          //       color: const Color(0xFFFE4545),
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //     child: const Text(
          //       "Logout",
          //       textAlign: TextAlign.center,
          //       style: TextStyle(
          //         fontSize: 17,
          //       ),
          //     ),
          //   ),
          // ),
          ),
    );
  }
}
