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

  Future<void> Addmessage(MessageDatamodel message, String reuid) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    String reciverid = reuid.trim().toString();
    String chatid = '${uid}_$reciverid';
    CollectionReference chatroom =
        FirebaseFirestore.instance.collection('Chatroom');
    QuerySnapshot querySnapshot =
        await chatroom.doc(chatid).collection('Message').get();
    final messageexists = querySnapshot.size;
    if (messageexists != 0) {
      await FirebaseFirestore.instance
          .collection('Chatroom')
          .doc(chatid)
          .collection('Message')
          .add(message.toMap());
    } else {
      chatid = '${reciverid}_${uid}';
      await FirebaseFirestore.instance
          .collection('Chatroom')
          .doc(chatid)
          .collection('Message')
          .add(message.toMap());
    }
  }
}
