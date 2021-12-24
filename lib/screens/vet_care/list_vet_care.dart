import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/services/appointment_db_service.dart';
import '../../core/services/vet_care_db_service.dart';
import '../../core/widget/text_fied.dart';
import 'vet_care_detail.dart';

class ListVetCare extends StatefulWidget {
  const ListVetCare({Key? key}) : super(key: key);

  @override
  State<ListVetCare> createState() => _ListVetCareState();
}

class _ListVetCareState extends State<ListVetCare> {
  final _ctrlSearch = TextEditingController();

  final _focusNodeSearch = FocusNode();

  String _searchQuery = '';

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
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldSearch(
                        ctrl: _ctrlSearch,
                        focusNode: _focusNodeSearch,
                        onSubmitted: (val) {
                          setState(() {
                            _searchQuery = val;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      FutureBuilder<QuerySnapshot>(
                        future: context
                            .read<VetCareDatabaseService>()
                            .dataVetCare(_searchQuery),
                        builder: (_, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.data!.size > 0) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  (_searchQuery.isEmpty)
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 10,
                                          ),
                                          child: Text(
                                            "Recommended Vet Practice",
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                  Column(
                                    children: snapshot.data!.docs
                                        .map(
                                          (e) => VetCareCard(
                                            name: e['name'],
                                            address:
                                                "${e['address']}, ${e['city']}",
                                            image: e['picture'],
                                            uid: e.id,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              );
                            } else {
                              return const Center(
                                child: Text(
                                  "Data Not Found\n\nValues Are Case Sensitive",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class VetCareCard extends StatefulWidget {
  const VetCareCard({
    Key? key,
    required this.name,
    required this.address,
    required this.image,
    required this.uid,
  }) : super(key: key);

  final String name;
  final String address;
  final String image;
  final String uid;

  @override
  State<VetCareCard> createState() => _VetCareCardState();
}

class _VetCareCardState extends State<VetCareCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VetCareDetail(
              uid: widget.uid,
            ),
          ),
        ).then((value) => setState(() {}));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.image,
                    progressIndicatorBuilder: (context, _, progress) =>
                        Container(
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
                    errorWidget: (context, _, error) => const Icon(Icons.error),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.30,
                    height: MediaQuery.of(context).size.width * 0.30,
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
                      children: [
                        const Icon(
                          Icons.star_rate_rounded,
                          size: 18,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 5),
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

                                textRating = rating.toStringAsPrecision(2);
                              } else {
                                textRating = "0.0";
                              }
                            } else {
                              textRating = "0.0";
                            }

                            return Text(
                              textRating,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            );
                          },
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
                      widget.name,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.address,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
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
