import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect2prof/usermodel/MessageDatamodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AddchatDetails {
  Future<void> AddStatus(String Status) async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (Status == 'false') {
      String Time = DateTime.now().millisecondsSinceEpoch.toString();
      await users.doc(uid).update({'Lastseen': Time});
    }
    await users.doc(uid).update({'is_online': Status});
  }

  Future<void> Addmessage(MessageDatamodel message, String chatid) async {
      await FirebaseFirestore.instance
          .collection('Chatroom')
          .doc(chatid)
          .collection('Message')
          .add(message.toMap());
  }
}
