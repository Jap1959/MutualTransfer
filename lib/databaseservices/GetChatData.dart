import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../usermodel/MessageDatamodel.dart';
import '../usermodel/usermodel.dart';

class GetChatData {
  String formatTimeAgo(int milliseconds) {
    DateTime currentTime = DateTime.now();
    DateTime convertedTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);

    Duration difference = currentTime.difference(convertedTime);
    print(milliseconds);
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hr ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      int weeks = (difference.inDays / 7).floor();
      return '${weeks} week${weeks > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 365) {
      int months = (difference.inDays / 30).floor();
      return '${months} month${months > 1 ? 's' : ''} ago';
    } else {
      int years = (difference.inDays / 365).floor();
      return '${years} year${years > 1 ? 's' : ''} ago';
    }
  }

  Stream<List<UserDatamodel>> ChatList() async* {
    List<UserDatamodel> users = [];
    try {
      List<Future<void>> futures = [];
      final uid = FirebaseAuth.instance.currentUser?.uid;
      CollectionReference chatlist =
          FirebaseFirestore.instance.collection('Users/$uid/ChatRoom');
      QuerySnapshot snapshot = await chatlist.get();
      for (DocumentSnapshot doc in snapshot.docs) {
        String docid = doc.id;
        List<String> parts = docid.split('_');
        print(parts[0]);
        if (parts[0] != uid) {
          futures.add(FirebaseFirestore.instance
              .collection('Users')
              .doc(parts[0])
              .get()
              .then((snapshot) {
            final status = formatTimeAgo(int.parse(snapshot['Lastseen']));
            UserDatamodel user = UserDatamodel(
                Name: snapshot['Name'],
                Email: snapshot['Email'],
                currentplace: snapshot['currentplace'],
                Mobile_no: snapshot['Mobile_no'],
                Profilepic: snapshot['Profilepic'],
                Proffession: snapshot['Proffession'],
                is_online: snapshot['is_online'],
                LastSeen: status,
                uid: snapshot['uid']);
            users.add(user);
          }));
          await Future.wait(futures);
        } else {
          futures.add(FirebaseFirestore.instance
              .collection('Users')
              .doc(parts[1])
              .get()
              .then((snapshot) {
            final status = formatTimeAgo(int.parse(snapshot['Lastseen']));
            UserDatamodel user = UserDatamodel(
                Name: snapshot['Name'],
                Email: snapshot['Email'],
                currentplace: snapshot['currentplace'],
                Mobile_no: snapshot['Mobile_no'],
                Profilepic: snapshot['Profilepic'],
                Proffession: snapshot['Proffession'],
                is_online: snapshot['is_online'],
                LastSeen: status,
                uid: snapshot['uid']);
            users.add(user);
          }));
          await Future.wait(futures);
        }
      }
      yield users;
    } catch (e) {
      print(e.toString());
      yield users;
    }
  }

  Future<List<UserDatamodel>> ChatLists() async {
    List<UserDatamodel> users = [];
    try {
      List<Future<void>> futures = [];
      final uid = FirebaseAuth.instance.currentUser?.uid;
      CollectionReference chatlist =
          FirebaseFirestore.instance.collection('Users/$uid/ChatRoom');
      QuerySnapshot snapshot = await chatlist.get();
      for (DocumentSnapshot doc in snapshot.docs) {
        String docid = doc.id;
        List<String> parts = docid.split('_');
        print(parts[0]);
        if (parts[0] != uid) {
          futures.add(FirebaseFirestore.instance
              .collection('Users')
              .doc(parts[0])
              .get()
              .then((snapshot) {
            final status = formatTimeAgo(int.parse(snapshot['Lastseen']));
            UserDatamodel user = UserDatamodel(
                Name: snapshot['Name'],
                Email: snapshot['Email'],
                currentplace: snapshot['currentplace'],
                Mobile_no: snapshot['Mobile_no'],
                Profilepic: snapshot['Profilepic'],
                Proffession: snapshot['Proffession'],
                is_online: snapshot['is_online'],
                LastSeen: status,
                uid: snapshot['uid']);
            users.add(user);
          }));
          await Future.wait(futures);
        } else {
          futures.add(FirebaseFirestore.instance
              .collection('Users')
              .doc(parts[1])
              .get()
              .then((snapshot) {
            final status = formatTimeAgo(int.parse(snapshot['Lastseen']));
            UserDatamodel user = UserDatamodel(
                Name: snapshot['Name'],
                Email: snapshot['Email'],
                currentplace: snapshot['currentplace'],
                Mobile_no: snapshot['Mobile_no'],
                Profilepic: snapshot['Profilepic'],
                Proffession: snapshot['Proffession'],
                is_online: snapshot['is_online'],
                LastSeen: status,
                uid: snapshot['uid']);
            users.add(user);
          }));
          await Future.wait(futures);
        }
      }
      return users;
    } catch (e) {
      print(e.toString());
      return users;
    }
  }

  Stream<List<MessageDatamodel>> GetChats(String reciveruid) async* {
    final uidmain = FirebaseAuth.instance.currentUser?.uid;

    try {
      reciveruid = reciveruid.trim();
      String uid = uidmain.toString().trim();
      String Chatid = '${uid}_$reciveruid';
      CollectionReference message1 = FirebaseFirestore.instance
          .collection('Chatroom')
          .doc(Chatid)
          .collection('Message');

      print(Chatid);
      // Chatid = 'fQxDHhFyAYSKVI3HYiPMN509PkC2_rVelyRblfEVj5CN8hdE8i8a7JTv2';
      CollectionReference chatroomCollection = FirebaseFirestore.instance
          .collection('Chatroom')
          .doc(Chatid)
          .collection('Message');

      QuerySnapshot snapshot = await chatroomCollection.get();
      if (snapshot.size != 0) {
        QuerySnapshot querySnapshot1 = await message1.get();
        List<MessageDatamodel> messages = [];

        for (DocumentSnapshot doc in querySnapshot1.docs) {
          MessageDatamodel message = MessageDatamodel(
            PostedByUserid: doc['PostedByUserid'],
            Date: doc['Date'],
            message: doc['message'],
          );
          messages.add(message);
        }

        yield messages;
      } else {
        Chatid = '${reciveruid}_$uid';
        CollectionReference message2 = FirebaseFirestore.instance
            .collection('Chatroom')
            .doc(Chatid)
            .collection('Message');

        QuerySnapshot querySnapshot2 = await message2.get();
        List<MessageDatamodel> messages = [];

        for (DocumentSnapshot doc in querySnapshot2.docs) {
          MessageDatamodel message = MessageDatamodel(
            PostedByUserid: doc['PostedByUserid'],
            Date: doc['Date'],
            message: doc['message'],
          );
          messages.add(message);
        }

        yield messages;
      }
    } catch (e) {
      print('Error retrieving messages: $e');
      yield [];
    }
  }
}
