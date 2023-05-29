// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class StreamData {
//   Stream<List<String>> getUserStream(String userId) {
//     return FirebaseFirestore.instance
//         .collection('Users')
//         .doc(userId)
//         .snapshots()
//         .listen((event) {
//       final cities = [];
//       for (var doc in event.docs) {}
//       print("cities in CA: ${cities.join(", ")}");
//     });
//   }
// }
