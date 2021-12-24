import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../helper/string_helper.dart';
import '../../services/vet_care_db_service.dart';

// ignore: must_be_immutable
class CardAppointment extends StatelessWidget {
  CardAppointment({
    Key? key,
    required this.date,
    required this.time,
    required this.status,
    required this.uidVetCare,
    required this.onTap,
  }) : super(key: key);

  final String date;
  final String time;
  final int status;
  final String uidVetCare;
  final GestureTapCallback onTap;

  String statusText = "null";
  Color borderColor = Colors.grey;
  Color backColor = Colors.grey.shade50;
  Color textColor = Colors.grey.shade700;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(date);
    String dateFormat = DateFormat("dd MMM yyyy").format(dateTime);

    switch (status) {
      case -2:
        statusText = "Canceled";
        borderColor = Colors.red;
        backColor = Colors.red.shade50;
        textColor = Colors.red.shade700;
        break;
      case -1:
        statusText = "Rejected";
        borderColor = Colors.red;
        backColor = Colors.red.shade50;
        textColor = Colors.red.shade700;
        break;
      case 0:
        statusText = "Waiting";
        borderColor = Colors.grey;
        backColor = Colors.grey.shade50;
        textColor = Colors.grey.shade700;
        break;
      case 1:
        statusText = "Approved";
        borderColor = Colors.blue;
        backColor = Colors.blue.shade50;
        textColor = Colors.blue.shade700;
        break;
      case 2:
        statusText = "Done";
        borderColor = Colors.green;
        backColor = Colors.green.shade50;
        textColor = Colors.green.shade700;
        break;
      case 3:
        statusText = "Done";
        borderColor = Colors.green;
        backColor = Colors.green.shade50;
        textColor = Colors.green.shade700;
        break;
      default:
        statusText = "null";
        borderColor = Colors.grey;
        backColor = Colors.grey.shade50;
        textColor = Colors.grey.shade700;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: FutureBuilder<DocumentSnapshot>(
          future: context
              .read<VetCareDatabaseService>()
              .dataVetCareDetail(uidVetCare),
          builder: (_, snapshot) {
            var imgUrl = StringHelper.defaultImage;
            var vetCare = "-";

            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data!.exists) {
                imgUrl = snapshot.data!['picture'];
                vetCare = snapshot.data!['name'];
              }
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(15),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: imgUrl,
                    placeholder: (context, url) => Container(
                      color: Colors.black26,
                      child: Center(
                        child: SpinKitChasingDots(
                          size: 25,
                          color: Colors.red.shade900,
                        ),
                      ),
                    ),
                    errorWidget: (context, _, error) => Container(
                      color: Colors.black26,
                      child: Icon(
                        Icons.error_outline_rounded,
                        size: 40,
                        color: Colors.red.shade700,
                      ),
                    ),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.width * 0.25,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.25,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vetCare,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          "$dateFormat, $time",
                          maxLines: 1,
                          style: const TextStyle(
                            letterSpacing: 0.25,
                          ),
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            decoration: BoxDecoration(
                              color: backColor,
                              border: Border.all(
                                color: borderColor,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 5,
                            ),
                            child: Text(
                              statusText,
                              style: TextStyle(
                                color: textColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
