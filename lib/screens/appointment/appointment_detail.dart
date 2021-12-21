import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:petto/core/widget/behavior.dart';
import 'package:petto/core/widget/flushbar.dart';

// ignore: must_be_immutable
class AppointmentDetail extends StatelessWidget {
  AppointmentDetail({
    Key? key,
    required this.status,
    required this.rating,
  }) : super(key: key);

  final int status;
  final double rating;
  String statusText = "null";
  Color textColor = Colors.grey.shade700;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse("2021-12-17");
    String day = DateFormat("EEEE").format(dateTime);
    String dateFormat = DateFormat("dd MMMM yyyy").format(dateTime);

    List<Icon> iconRating = [];

    var rate = rating.floor();
    for (var i = 0; i < rate; i++) {
      iconRating.add(
        Icon(
          Icons.star,
          size: 19,
          color: Colors.yellow.shade800,
        ),
      );
    }

    var half = rating % 1;
    if (half > 0) {
      iconRating.add(
        Icon(
          Icons.star_half,
          size: 19,
          color: Colors.yellow.shade800,
        ),
      );
    }

    var empty = 5 - rating.ceil();
    for (var i = 0; i < empty; i++) {
      iconRating.add(
        Icon(
          Icons.star_border,
          size: 19,
          color: Colors.yellow.shade800,
        ),
      );
    }

    switch (status) {
      case -2:
        statusText = "Canceled";
        textColor = Colors.red.shade700;
        break;
      case -1:
        statusText = "Rejected";
        textColor = Colors.red.shade700;
        break;
      case 0:
        statusText = "Waiting";
        textColor = Colors.grey.shade700;
        break;
      case 1:
        statusText = "Approved";
        textColor = Colors.blue.shade700;
        break;
      case 2:
        statusText = "Done";
        textColor = Colors.green.shade700;
        break;
      case 3:
        statusText = "Done";
        textColor = Colors.green.shade700;
        break;
      default:
        statusText = "null";
        textColor = Colors.grey.shade700;
    }

    return SafeArea(
      child: Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/header.png',
              ),
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
            ),
          ),
          child: CustomScrollBehavior(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.grey.shade200,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  title: Text(
                    "Appointment",
                    style: TextStyle(
                      color: Colors.grey.shade200,
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 20,
                    ),
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red.shade50,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Petto",
                            style: GoogleFonts.ribeyeMarrow(
                              fontSize: 40,
                              color: Colors.red.shade900,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              statusText,
                              style: TextStyle(
                                color: textColor,
                                fontSize: 16.5,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: iconRating,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        const Divider(
                          color: Colors.black26,
                          thickness: 1.5,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.local_hospital_outlined),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text("Vet Care"),
                                  SizedBox(height: 5),
                                  Text(
                                    "Aliqua nostrud est exercitation nostrud est exercitation nostrud est exercitation",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            const Icon(Icons.date_range_rounded),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Date"),
                                  const SizedBox(height: 5),
                                  Text(
                                    "$day, $dateFormat",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            const Icon(Icons.access_time_filled),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text("Time"),
                                  SizedBox(height: 5),
                                  Text(
                                    "09:00",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Icon(Icons.description),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text("Note"),
                                  SizedBox(height: 5),
                                  Text(
                                    "Lorem aliquip sint adipisicing id sit dolore laborum sit adipisicing. Tempor voluptate voluptate in dolor do. Culpa laborum excepteur Lorem exercitation. Ad minim irure commodo ipsum cillum aute excepteur esse ullamco ipsum ullamco. Velit excepteur ad amet enim non exercitation aliqua tempor quis ut eu sunt. Excepteur tempor ad dolore excepteur exercitation magna sit.",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        (status == 2)
                            ? GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    builder: (context) => Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                            0,
                                            8,
                                            0,
                                            30,
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade700,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                        const Text(
                                          "Thank You For Using Our Service",
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 20,
                                          ),
                                          child: RatingBar.builder(
                                            initialRating: 0,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            glow: false,
                                            itemCount: 5,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 4.0,
                                            ),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              var rate = rating.floor();
                                              var half = rating % 1;
                                              log("$rate ${(half == 0) ? false : true}");
                                            },
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 40,
                                            vertical: 25,
                                          ),
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color: Colors.deepOrange.shade400,
                                            borderRadius: BorderRadius.circular(
                                              50,
                                            ),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "Rate",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  margin: const EdgeInsets.fromLTRB(
                                    5,
                                    30,
                                    5,
                                    0,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      50,
                                    ),
                                    color: Colors.deepOrange.shade400,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Rate",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        (status == 0 || status == 1)
                            ? GestureDetector(
                                onTap: () {
                                  if (status == 0) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text(
                                          "Cancel Appointment",
                                        ),
                                        content: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              "Are you sure ?",
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "You can't cancel once this appointment is approved",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                          24,
                                          20,
                                          24,
                                          10,
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text(
                                              "No",
                                              style: TextStyle(
                                                color: Colors.grey.shade800,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text(
                                              "Yes",
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    Alert.error(
                                      context: context,
                                      msg: "Appointment can't be canceled",
                                    );
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  margin:
                                      const EdgeInsets.fromLTRB(5, 30, 5, 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: (status == 0)
                                        ? Colors.red.shade600
                                        : Colors.grey.shade400,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
