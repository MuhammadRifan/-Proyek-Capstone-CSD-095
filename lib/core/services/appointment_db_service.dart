import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentDatabaseService {
  AppointmentDatabaseService({
    required this.appointmentCollection,
  });

  final CollectionReference appointmentCollection;

  Future addAppointment({
    required String uidUser,
    required String uidDoctor,
    required String uidVetCare,
    required String date,
    required String time,
    required String note,
    required String nameVetCare,
    required String pictureVetCare,
    required int status,
    required double rating,
  }) async {
    var realNote = "";

    if (note.isEmpty) {
      realNote = "-";
    } else {
      realNote = note;
    }

    return await appointmentCollection.add({
      'uidUser': uidUser,
      'uidDoctor': uidDoctor,
      'uidVetCare': uidVetCare,
      'nameVetCare': nameVetCare,
      'pictureVetCare': pictureVetCare,
      'date': date,
      'time': time,
      'note': realNote,
      'status': status,
      'rating': rating,
    });
  }

  Future<QuerySnapshot> dataMyAppointment(String uid, int jenis) async {
    if (jenis == 0) {
      return await appointmentCollection.where('uidUser', isEqualTo: uid).get();
    } else {
      return await appointmentCollection
          .where('uidDoctor', isEqualTo: uid)
          .get();
    }
  }

  Future<DocumentSnapshot> dataAppointmentDetail(String uId) async {
    return await appointmentCollection.doc(uId).get();
  }

  Future<QuerySnapshot> dataRating(String uid) async {
    return await appointmentCollection
        .where('uidVetCare', isEqualTo: uid)
        .get();
  }

  Future updateAppointmentStatus({
    required String uid,
    required int status,
  }) async {
    return await appointmentCollection.doc(uid).update({
      'status': status,
    });
  }

  Future ratingAppointment({
    required String uid,
    required double rating,
  }) async {
    return await appointmentCollection.doc(uid).update({
      'status': 3,
      'rating': rating,
    });
  }
}
