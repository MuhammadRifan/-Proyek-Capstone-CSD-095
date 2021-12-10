import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/widget/text_fied.dart';

class ListClinic extends StatefulWidget {
  const ListClinic({Key? key}) : super(key: key);

  @override
  State<ListClinic> createState() => _ListClinicState();
}

class _ListClinicState extends State<ListClinic> {
  final _ctrlSearch = TextEditingController();

  final _focusNodeSearch = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FieldSearch(
                    ctrl: _ctrlSearch,
                    focusNode: _focusNodeSearch,
                    onSubmitted: (val) {},
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Recommended Vet Practice",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            CachedNetworkImage(
                              imageUrl: "http://via.placeholder.com/350x150",
                              progressIndicatorBuilder:
                                  (context, _, progress) => Container(
                                color: const Color(0xFFFFA1A1),
                                child: Center(
                                  child: SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: CircularProgressIndicator(
                                      value: progress.progress,
                                      color: Colors.red.shade900,
                                    ),
                                  ),
                                ),
                              ),
                              errorWidget: (context, _, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: MediaQuery.of(context).size.width * 0.35,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFA68F3E),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                ),
                              ),
                              padding: const EdgeInsets.fromLTRB(15, 5, 13, 7),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.star_rate_rounded,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "3.5",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Vet Care",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Bandung, Jawa Barat",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            // Container(
                            //   width: MediaQuery.of(context).size.width * 0.35,
                            //   height: MediaQuery.of(context).size.width * 0.35,
                            //   // decoration: BoxDecoration(
                            //   color: Colors.blue,
                            //   //   borderRadius: BorderRadius.circular(20),
                            //   // ),
                            // ),
                            CachedNetworkImage(
                              imageUrl: "http://via.placeholder.com/350x150",
                              progressIndicatorBuilder:
                                  (context, _, progress) => Container(
                                color: Color(0xFFFFA1A1),
                                child: Center(
                                  child: SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: CircularProgressIndicator(
                                      value: progress.progress,
                                      color: Colors.red.shade900,
                                    ),
                                  ),
                                ),
                              ),
                              errorWidget: (context, _, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: MediaQuery.of(context).size.width * 0.35,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFA68F3E),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                ),
                              ),
                              padding: const EdgeInsets.fromLTRB(15, 5, 13, 7),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.star_rate_rounded,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "3.5",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Vet Care",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Bandung, Jawa Barat",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            // Container(
                            //   width: MediaQuery.of(context).size.width * 0.35,
                            //   height: MediaQuery.of(context).size.width * 0.35,
                            //   // decoration: BoxDecoration(
                            //   color: Colors.blue,
                            //   //   borderRadius: BorderRadius.circular(20),
                            //   // ),
                            // ),
                            CachedNetworkImage(
                              imageUrl: "http://via.placeholder.com/350x150",
                              progressIndicatorBuilder:
                                  (context, _, progress) => Container(
                                color: Color(0xFFFFA1A1),
                                child: Center(
                                  child: SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: CircularProgressIndicator(
                                      value: progress.progress,
                                      color: Colors.red.shade900,
                                    ),
                                  ),
                                ),
                              ),
                              errorWidget: (context, _, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: MediaQuery.of(context).size.width * 0.35,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFA68F3E),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                ),
                              ),
                              padding: const EdgeInsets.fromLTRB(15, 5, 13, 7),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.star_rate_rounded,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "3.5",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Vet Care",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Bandung, Jawa Barat",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            // Container(
                            //   width: MediaQuery.of(context).size.width * 0.35,
                            //   height: MediaQuery.of(context).size.width * 0.35,
                            //   // decoration: BoxDecoration(
                            //   color: Colors.blue,
                            //   //   borderRadius: BorderRadius.circular(20),
                            //   // ),
                            // ),
                            CachedNetworkImage(
                              imageUrl: "http://via.placeholder.com/350x150",
                              progressIndicatorBuilder:
                                  (context, _, progress) => Container(
                                color: Color(0xFFFFA1A1),
                                child: Center(
                                  child: SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: CircularProgressIndicator(
                                      value: progress.progress,
                                      color: Colors.red.shade900,
                                    ),
                                  ),
                                ),
                              ),
                              errorWidget: (context, _, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: MediaQuery.of(context).size.width * 0.35,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFA68F3E),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                ),
                              ),
                              padding: const EdgeInsets.fromLTRB(15, 5, 13, 7),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.star_rate_rounded,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "3.5",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Vet Care",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Bandung, Jawa Barat",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            // Container(
                            //   width: MediaQuery.of(context).size.width * 0.35,
                            //   height: MediaQuery.of(context).size.width * 0.35,
                            //   // decoration: BoxDecoration(
                            //   color: Colors.blue,
                            //   //   borderRadius: BorderRadius.circular(20),
                            //   // ),
                            // ),
                            CachedNetworkImage(
                              imageUrl: "http://via.placeholder.com/350x150",
                              progressIndicatorBuilder:
                                  (context, _, progress) => Container(
                                color: Color(0xFFFFA1A1),
                                child: Center(
                                  child: SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: CircularProgressIndicator(
                                      value: progress.progress,
                                      color: Colors.red.shade900,
                                    ),
                                  ),
                                ),
                              ),
                              errorWidget: (context, _, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: MediaQuery.of(context).size.width * 0.35,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFA68F3E),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                ),
                              ),
                              padding: const EdgeInsets.fromLTRB(15, 5, 13, 7),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.star_rate_rounded,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "3.5",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Vet Care",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Bandung, Jawa Barat",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            // Container(
                            //   width: MediaQuery.of(context).size.width * 0.35,
                            //   height: MediaQuery.of(context).size.width * 0.35,
                            //   // decoration: BoxDecoration(
                            //   color: Colors.blue,
                            //   //   borderRadius: BorderRadius.circular(20),
                            //   // ),
                            // ),
                            CachedNetworkImage(
                              imageUrl: "http://via.placeholder.com/350x150",
                              progressIndicatorBuilder:
                                  (context, _, progress) => Container(
                                color: Color(0xFFFFA1A1),
                                child: Center(
                                  child: SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: CircularProgressIndicator(
                                      value: progress.progress,
                                      color: Colors.red.shade900,
                                    ),
                                  ),
                                ),
                              ),
                              errorWidget: (context, _, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: MediaQuery.of(context).size.width * 0.35,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFA68F3E),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                ),
                              ),
                              padding: const EdgeInsets.fromLTRB(15, 5, 13, 7),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.star_rate_rounded,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "3.5",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Vet Care",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Bandung, Jawa Barat",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
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
