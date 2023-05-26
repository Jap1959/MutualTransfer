


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../usermodel/MessageDatamodel.dart';
import '../usermodel/usermodel.dart';

class GetChatData {
  Future<List<UserDatamodel>> ChatList() async {
    List<UserDatamodel> users = [];
    try {
      List<Future<void>> futures = [];
      final uid = FirebaseAuth.instance.currentUser?.uid;
      CollectionReference chatlist = FirebaseFirestore.instance.collection('Users/$uid/ChatRoom');
      QuerySnapshot snapshot = await chatlist.get();
        Map<String, dynamic> chatroom = snapshot;
        for (var user in chatroom.entries) {
          String uidRecieveruid = user.value;
          List<String> parts = uidRecieveruid.split('_');
          print(parts[1]);
          futures.add(FirebaseFirestore.instance
              .collection('Users')
              .doc(parts[1])
              .get()
              .then((snapshot) {
            UserDatamodel Person = UserDatamodel(Name: snapshot['Name'],
                Email: snapshot['Email'],
                currentplace: snapshot['currentplace'],
                Mobile_no: snapshot['Mobile_no'],
                Profilepic: snapshot['Profilepic'],
                Proffession: snapshot['Proffession'], is_online: snapshot['is_online'], LastSeen: snapshot['Lastseen'], uid: snapshot['uid']);
            users.add(Person);
          }));
        }
        await Future.wait(futures);
      }
      return users;
    }
    catch (e) {
      print(e.toString());
      return users;
    }
  }
  Future<List<MessageDatamodel>> GetChats(String reciveruid)async {
    List<MessageDatamodel> Messages = [];
    final uid = FirebaseAuth.instance.currentUser?.uid;
    CollectionReference post = FirebaseFirestore.instance.collection(
        'ChatRoom/${uid}_${reciveruid}/Messages');
    QuerySnapshot snapshot = await post.get();
    try {
      for (DocumentSnapshot doc in snapshot.docs) {
        MessageDatamodel mess = MessageDatamodel(
            PostedByUserid: doc['PostedByUserid'],
            Date: doc['Date'],
            message: doc['message']);
        Messages.add(mess);
      }
      return Messages;
    }catch(e){
      print(e.toString());
      return Messages;
    }
  }
}