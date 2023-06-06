import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
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
  Future<String> GetChatid(String reciveruid) async{
    final uidmain = FirebaseAuth.instance.currentUser?.uid;
       try{
         reciveruid = reciveruid.trim();
         String uid = uidmain.toString().trim();
         String Chatid = '${uid}_$reciveruid';
         CollectionReference chatroomCollection = FirebaseFirestore.instance
             .collection('Chatroom')
             .doc(Chatid)
             .collection('Message');

         QuerySnapshot snapshot = await chatroomCollection.get();
         if(snapshot.size!=0){
           return Chatid;
         }
         else{
           Chatid = '${reciveruid}_$uid';
           return Chatid;
         }
       }
       catch(e){
           return e.toString();
       }
  }
  Map<String, List<MessageDatamodel>> OrderChatData(List<DocumentSnapshot>  docs){
     Map<String, List<MessageDatamodel>> messages={};
     for (int i = 0; i < docs.length; i++) {
       DocumentSnapshot doc = docs[i];
       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
       final Time =formatTimestamp(int.parse(data['Date']));
       DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(data['Date']));
       final mesage=MessageDatamodel(PostedByUserid: data['PostedByUserid'], Date:DateFormat('h:mm a').format(dateTime) , message:data['message']);
       if(mesage!=null) {
         messages[Time] ??= [];
         messages[Time]!.add(mesage);
       }
     }
     return messages;
   }
  List<String> filterUsers(QuerySnapshot<Map<String, dynamic>> users, String searchValue) {
    List<String> userList = [];
    if(searchValue==''){
      for (QueryDocumentSnapshot<Map<String, dynamic>> userSnapshot in users.docs) {
        Map<String, dynamic> userData = userSnapshot.data();
        userList.add(userData['Chatid']);
      }
      return userList;
    }
    for (QueryDocumentSnapshot<Map<String, dynamic>> userSnapshot in users.docs) {
      Map<String, dynamic> userData = userSnapshot.data();
      String userName = userData['NameOfReciver'];

      // Apply filtering logic based on the search value
      if (userName.toLowerCase().contains(searchValue.toLowerCase())) {
        String userId = userData['Chatid'];
        userList.add(userId);
      }
    }
    return userList;
  }
  String formatTimestamp(int timestamp) {
    DateTime now = DateTime.now();
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);

    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      // Today
      return 'Today';
    } else if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day - 1) {
      // Yesterday
      return 'Yesterday';
    } else {
      // Other dates
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
