import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../core/services/appointment_db_service.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/user_db_service.dart';
import '../../core/services/vet_care_db_service.dart';
import '../../core/widget/flushbar.dart';
import '../../core/widget/text_fied.dart';

// ignore: must_be_immutable
class VetCareDetail extends StatefulWidget {
  VetCareDetail({
    Key? key,
    required this.uid,
  }) : super(key: key);

  final String uid;

  @override
  State<VetCareDetail> createState() => _VetCareDetailState();
}

class _VetCareDetailState extends State<VetCareDetail> {
  final _ctrlDate = TextEditingController();
  final _ctrlTime = TextEditingController();
  final _ctrlNote = TextEditingController();

  final List _day = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  final Set _dayView = {};

  String? _doctorUid;
  String? _imageVetCare;
  String? _nameVetCare;

  @override
  void dispose() {
    _ctrlDate.dispose();
    _ctrlTime.dispose();
    _ctrlNote.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          var userData = context.read<AuthService>().userData;
          var user = await context
              .read<UserDatabaseService>()
              .checkUserData(userData!.uid);

          if (user['jenis'] == 1) {
            return Alert.error(
              context: context,
              msg: "Only user can make appointment",
            );
          } else {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              elevation: 1,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 8, 0, 30),
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: FieldDateTime(
                      ctrlText: _ctrlDate,
                      hint: "Select Date",
                      disableBackDate: true,
                      borderOutline: false,
                      onSaved: (val) {},
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: FieldDateTime(
                      ctrlText: _ctrlTime,
                      hint: "Select Time",
                      timeInput: true,
                      borderOutline: false,
                      onSaved: (val) {
                        log(val.toString());
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: FieldInput(
                      controller: _ctrlNote,
                      hint: "Note (Optional)",
                      maxLength: 50,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_ctrlDate.text.isEmpty) {
                        // ignore: void_checks
                        return Alert.error(
                          context: context,
                          msg: "Please choose a date",
                        );
                      }

                      if (_ctrlTime.text.isEmpty) {
                        // ignore: void_checks
                        return Alert.error(
                          context: context,
                          msg: "Please choose a time",
                        );
                      }

                      await context
                          .read<AppointmentDatabaseService>()
                          .addAppointment(
                            uidUser: userData.uid,
                            uidDoctor: _doctorUid!,
                            uidVetCare: widget.uid,
                            nameVetCare: _nameVetCare!,
                            pictureVetCare: _imageVetCare!,
                            date: _ctrlDate.text,
                            time: _ctrlTime.text,
                            note: _ctrlNote.text,
                            status: 0,
                            rating: 0.0,
                          );

                      Navigator.pop(context);

                      Alert.success(
                        context: context,
                        msg: "Appointment Sent",
                      );
                      log(_ctrlDate.text + " , " + _ctrlTime.text);
                    },
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 25,
                      ),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFA1A1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Center(
                        child: Text(
                          "Make Appointment",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
        icon: Icon(
          Icons.event,
          color: Colors.grey.shade900,
        ),
        label: Text(
          "Make an Appointment",
          style: TextStyle(
            color: Colors.grey.shade900,
          ),
        ),
        backgroundColor: const Color(0xFFFFA1A1),
      ),
      body: DecoratedBox(
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
        child: FutureBuilder<DocumentSnapshot>(
          future: context
              .read<VetCareDatabaseService>()
              .dataVetCareDetail(widget.uid),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data!.exists) {
                Set _temp = {};
                for (var day in snapshot.data!['workDay']) {
                  _temp.add(day);
                }
                for (var item in _day) {
                  if (_temp.contains(item)) {
                    _dayView.add(item);
                  }
                }

                _doctorUid = snapshot.data!['uidDoctor'];
                _imageVetCare = snapshot.data!['picture'];
                _nameVetCare = snapshot.data!['name'];

                return CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.grey.shade900,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      title: Text(
                        snapshot.data!['name'],
                        style: TextStyle(
                          color: Colors.grey.shade900,
                        ),
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            imageUrl: snapshot.data!['picture'],
                            placeholder: (context, url) => Container(
                              color: Colors.black26,
                              child: Center(
                                child: SpinKitChasingDots(
                                  size: 30,
                                  color: Colors.red.shade900,
                                ),
                              ),
                            ),
                            errorWidget: (context, _, error) => Container(
                              color: Colors.black26,
                              child: Icon(
                                Icons.error_outline_rounded,
                                size: 50,
                                color: Colors.red.shade700,
                              ),
                            ),
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.width * 0.8,
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.red.shade700,
                                  size: 23,
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    "${snapshot.data!['address']}, ${snapshot.data!['city']}",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.star_rate_rounded,
                                  color: Colors.amber.shade800,
                                  size: 23,
                                ),
                                const SizedBox(width: 7),
                                FutureBuilder<QuerySnapshot>(
                                  future: context
                                      .read<AppointmentDatabaseService>()
                                      .dataRating(widget.uid),
                                  builder: (_, snapshot) {
                                    double rating = 0.0;
                                    int totalRating = 0;
                                    String textRating = "0.0";

                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.data!.size > 0) {
                                        for (var item in snapshot.data!.docs) {
                                          rating += item['rating'];
                                          totalRating++;
                                        }

                                        rating = rating / totalRating;

                                        textRating =
                                            rating.toStringAsPrecision(2);
                                      } else {
                                        textRating = "0.0";
                                      }
                                    } else {
                                      textRating = "0.0";
                                    }

                                    return Text(
                                      textRating,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                const Icon(
                                  Icons.date_range_rounded,
                                  color: Colors.blue,
                                  size: 23,
                                ),
                                const SizedBox(width: 7),
                                Flexible(
                                  child: RichText(
                                    text:
                                        (snapshot.data!['workDay'].length == 7)
                                            ? const TextSpan(
                                                text: "Everyday",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.5,
                                                ),
                                              )
                                            : TextSpan(
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.5,
                                                ),
                                                children: _dayView.map(
                                                  (day) {
                                                    if (_dayView.last != day) {
                                                      return TextSpan(
                                                        text: "$day, ",
                                                      );
                                                    } else {
                                                      return TextSpan(
                                                        text: day,
                                                      );
                                                    }
                                                  },
                                                ).toList(),
                                              ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone_rounded,
                                  color: Colors.green.shade600,
                                  size: 23,
                                ),
                                const SizedBox(width: 7),
                                Expanded(
                                  child: Text(
                                    snapshot.data!['phone'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.access_time_filled,
                                  color: Colors.deepOrange,
                                  size: 23,
                                ),
                                const SizedBox(width: 7),
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: snapshot.data!['openHour'],
                                      ),
                                      const TextSpan(text: " - "),
                                      TextSpan(
                                        text: snapshot.data!['closeHour'],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 40,
                              thickness: 0.8,
                              color: Colors.red.shade400,
                              indent: 10,
                              endIndent: 10,
                            ),
                            Text(
                              snapshot.data!['description'],
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 80),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text(
                    "Oops! Something Went Wrong",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                );
              }
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
