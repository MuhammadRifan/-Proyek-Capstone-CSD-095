import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../core/widget/flushbar.dart';
import '../../core/widget/text_fied.dart';

class VetCareDetail extends StatelessWidget {
  VetCareDetail({Key? key}) : super(key: key);

  final _ctrlDate = TextEditingController();
  final _ctrlTime = TextEditingController();
  final _ctrlNote = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
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
                    onSaved: (val) {},
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
                    hint: "Note (Opsional)",
                    maxLength: 50,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (_ctrlDate.text.isEmpty) {
                      return Alert.error(
                        context: context,
                        msg: "Please choose a date",
                      );
                    }

                    if (_ctrlTime.text.isEmpty) {
                      return Alert.error(
                        context: context,
                        msg: "Please choose a time",
                      );
                    }
                    // DateTime date = DateTime.parse(_ctrlDate.text);
                    // String pickedTimeFormat = DateFormat("EEEE").format(date);
                    // log(pickedTimeFormat.toString());
                    
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
        child: CustomScrollView(
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
                "Vet Care",
                style: TextStyle(
                  color: Colors.grey.shade900,
                ),
              ),
              backgroundColor: Colors.transparent,
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                child: Text(
                  "Minim voluptate in aute non minim voluptate in aute non.",
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: "http://via.placeholder.com/500x500",
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
                        const Expanded(
                          child: Text(
                            "Jalan. Diponegoro" + ", " + "Surabaya",
                            style: TextStyle(
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
                        const Text(
                          "3.6",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
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
                            text: const TextSpan(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5,
                              ),
                              children: [
                                TextSpan(text: "Senin, "),
                                TextSpan(text: "Selasa, "),
                                TextSpan(text: "Rabu, "),
                                TextSpan(text: "Kamis, "),
                                // TextSpan(text: "Jum'at, "),
                                // TextSpan(text: "Sabtu, "),
                                TextSpan(text: "Minggu"),
                              ],
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
                        const Expanded(
                          child: Text(
                            "088283647829",
                            style: TextStyle(
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
                          text: const TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              TextSpan(text: "08:00"),
                              TextSpan(text: " - "),
                              TextSpan(text: "15:00"),
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
                    const Text(
                      '''Mollit esse eu deserunt cillum aliquip officia eiusmod aliquip id. In reprehenderit consequat ut magna cillum irure deserunt occaecat magna. Duis et esse quis cupidatat reprehenderit velit culpa sit incididunt nostrud incididunt nulla eiusmod dolor.\n\nQuis adipisicing excepteur nostrud non sunt consectetur labore sunt excepteur. Officia magna eiusmod eiusmod laborum deserunt do ut. In esse velit consectetur nostrud aliquip irure aliquip ex ullamco mollit. Consequat ad in qui consectetur culpa velit aliquip cupidatat anim duis sunt. Qui veniam commodo reprehenderit esse nisi in ad elit ullamco labore nulla cillum. Ex enim voluptate magna reprehenderit cillum est tempor duis laboris est. Deserunt tempor irure sunt ullamco.\n\nVeniam eiusmod culpa eu aute consectetur aliqua enim ad. Amet nulla amet ut voluptate. Esse ex duis irure qui cillum tempor fugiat nostrud elit irure eu minim excepteur magna. Tempor labore irure eu reprehenderit ut. Aliquip commodo culpa nulla et aliqua consequat adipisicing ullamco sunt reprehenderit. Sit cillum aute occaecat dolore do veniam quis officia ipsum exercitation. Enim nostrud minim elit magna reprehenderit nostrud anim.''',
                      style: TextStyle(
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
        ),
      ),
    );
  }
}
