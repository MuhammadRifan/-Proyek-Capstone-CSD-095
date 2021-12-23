import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/services/appointment_db_service.dart';
import '../../core/widget/card/card_appoinment.dart';
import 'appointment_detail.dart';

class ListAppointment extends StatefulWidget {
  const ListAppointment({
    Key? key,
    required this.uid,
    required this.jenis,
  }) : super(key: key);

  final String uid;
  final int jenis;

  @override
  State<ListAppointment> createState() => _ListAppointmentState();
}

class _ListAppointmentState extends State<ListAppointment> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          child: CustomScrollView(
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
                  "Appointments",
                  style: TextStyle(
                    color: Colors.grey.shade900,
                  ),
                ),
                backgroundColor: Colors.transparent,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: FutureBuilder<QuerySnapshot>(
                    future: context
                        .read<AppointmentDatabaseService>()
                        .dataMyAppointment(
                          widget.uid,
                          widget.jenis,
                        ),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data!.size > 0) {
                          return Column(
                            children: snapshot.data!.docs
                                .map(
                                  (data) => CardAppointment(
                                    date: data['date'],
                                    time: data['time'],
                                    status: data['status'],
                                    uidVetCare: data['uidVetCare'],
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AppointmentDetail(
                                            uid: data.id,
                                            jenis: widget.jenis,
                                          ),
                                        ),
                                      ).then((value) => setState(() {}));
                                    },
                                  ),
                                )
                                .toList(),
                          );
                        } else {
                          return const Center(
                            child: Text(
                              "Data Not Found",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
