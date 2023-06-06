

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect2prof/usermodel/MessageDatamodel.dart';
import 'package:connect2prof/usermodel/NotificationDatamodel.dart';
import 'package:connect2prof/usermodel/PostdataModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/Homepage.dart';
import '../usermodel/PostUploadDatamodel.dart';

int chatnumber = 0;

class AddData {
  Future<void> adddata(Map<String, dynamic> Data) async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      print(Data);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('Name', Data['Name']);
      prefs.setString('Mobile', Data['Mobile_no']);
      await users.doc(uid).set(Data);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> AddPost(PostUploaddataModel? Post) async {
    CollectionReference post = FirebaseFirestore.instance.collection('Post');
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? Name = prefs.getString('Name');
      String? Url = prefs.getString('Url');
      DateTime now = new DateTime.now();
      DateTime date = new DateTime(now.year, now.month, now.day);
      PostdataModel PostFinal = PostdataModel(
          DestinationPlace: Post!.DestinationPlace,
          Proffession: Post!.Proffession,
          description: Post!.description,
          PostedByUserid: Post!.PostedByUserid,
          MobileNo: Post.MobileNo,
          CurrentPlace: Post!.CurrentPlace,
          Name: Name!,
          Profilepic: Url!,
          Date: date.toString(),
          Time: now.toString());
      await post.add(PostFinal?.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> Addnotification(String uid) async {
    CollectionReference notification =
        FirebaseFirestore.instance.collection('Notification');
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      DateTime now = new DateTime.now();
      DateTime date = new DateTime(now.year, now.month, now.day);
      final notify = NotificationDatamodel(
          PostedByUserid: uid.toString(),
          Date: date.toString(),
          Time: now.toString(),
          message: 'Added a Post');
      notification.add(notify.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> AddChatroom(String recieveruid) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      recieveruid=recieveruid.trim();
      final Chatid = '${uid}_${recieveruid}';
      final CollectionReference collectionReference2 =
          FirebaseFirestore.instance.collection('Users/$recieveruid/ChatRoom');
      List<Future<void>> futures = [];
      String Time = DateTime.now().millisecondsSinceEpoch.toString();
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(recieveruid.trim())
          .collection('ChatRoom')
          .get();
      List<QueryDocumentSnapshot> documents = querySnapshot.docs;
      List<String> documentIds = documents.map((document) => document.id).toList();
      if(documentIds.contains(Chatid)||documentIds.contains('${recieveruid}_${uid}')){
        return;
      }
        DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();
        collectionReference2.doc(Chatid).set({
          'Datecreated': Time,
          'NameOfReciver': snapshot['Name'],
          'Chatid': Chatid
        });
        CollectionReference collectionReference1 =
        FirebaseFirestore.instance.collection('Users/$uid/ChatRoom');
        snapshot = await FirebaseFirestore.instance.collection('Users').doc(
            recieveruid.trim()).get();
        collectionReference1.doc(Chatid).set({
          'Datecreated': Time,
          'NameOfReciver': snapshot['Name'],
          'Chatid': Chatid
        });
        MessageDatamodel message = MessageDatamodel(
            PostedByUserid: 'System', Date: Time, message: 'Start your chat');
        futures.add(FirebaseFirestore.instance
            .collection('Chatroom')
            .doc(Chatid)
            .collection('Message')
            .add(message.toMap()));
        await Future.wait(futures);

    } catch (e) {
      print(e.toString());
    }
  }
}
