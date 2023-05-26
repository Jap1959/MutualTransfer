

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect2prof/usermodel/MessageDatamodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AddchatDetails{

  Future<void> AddStatus(String Status)async {
        CollectionReference users = FirebaseFirestore.instance.collection('Users');
        final uid =FirebaseAuth.instance.currentUser?.uid;
        if(Status=='false'){
          String Time=DateTime.now().millisecondsSinceEpoch.toString() ;
          await users.doc(uid).update({'Lastseen':Time });
        }
          await users.doc(uid).update({'is_online': Status});
  }
  Future<void> Addmessage(MessageDatamodel message,String reuid)async{
    final uid=FirebaseAuth.instance.currentUser?.uid;
    String chatid='${uid}_${reuid}';
    CollectionReference chatroom = FirebaseFirestore.instance.collection('ChatRoom');
    QuerySnapshot querySnapshot = await chatroom.get();
    List<String> chatids=[];
    querySnapshot.docs.forEach((document) {
      chatids.add(document.id);
    });
    if(chatid.contains(chatid)) {
      await FirebaseFirestore.instance.collection('ChatRoom/${chatid}/Messages')
          .add(message.toMap());
    }

  }

}