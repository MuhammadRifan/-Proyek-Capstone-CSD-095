import 'package:flutter/material.dart';

import '../../core/widget/card/card_appoinment.dart';
import 'appointment_detail.dart';

class ListAppointment extends StatelessWidget {
  const ListAppointment({Key? key}) : super(key: key);

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
                  child: Column(
                    children: [
                      CardAppointment(
                        imgUrl: "http://via.placeholder.com/100x100",
                        vetCare:
                            "Occaecat amet minim Occaecat amet minim Occaecat amet minim",
                        date: "2021-12-29",
                        time: "15:00",
                        status: 0,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AppointmentDetail(
                                status: 0,
                                rating: 0,
                              ),
                            ),
                          );
                        },
                      ),
                      CardAppointment(
                        imgUrl: "http://via.placeholder.com/500x500",
                        vetCare:
                            "Occaecat amet minim Occaecat amet minim Occaecat amet minim",
                        date: "2021-12-16",
                        time: "09:00",
                        status: 1,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AppointmentDetail(
                                status: 1,
                                rating: 0,
                              ),
                            ),
                          );
                        },
                      ),
                      CardAppointment(
                        imgUrl: "http://via.placeholder.com/500x150",
                        vetCare:
                            "Occaecat amet minim Occaecat amet minim Occaecat amet minim",
                        date: "2021-01-06",
                        time: "10:00",
                        status: 2,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AppointmentDetail(
                                status: 2,
                                rating: 4,
                              ),
                            ),
                          );
                        },
                      ),
                      CardAppointment(
                        imgUrl: "http://via.placeholder.com/200x250",
                        vetCare:
                            "Occaecat amet minim Occaecat amet minim Occaecat amet minim",
                        date: "2021-10-25",
                        time: "08:30",
                        status: -1,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AppointmentDetail(
                                status: -1,
                                rating: 0,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
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
