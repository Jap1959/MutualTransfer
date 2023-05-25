
  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect2prof/usermodel/NotificationDatamodel.dart';
import 'package:connect2prof/usermodel/Notificationgetdatamodel.dart';
import 'package:connect2prof/usermodel/PostUploadDatamodel.dart';
  import 'package:connect2prof/usermodel/PostdataModel.dart';
  import 'package:connect2prof/usermodel/usermodel.dart';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/cupertino.dart';

  class GetData{

    Future<List<PostdataModel>> DataForHomepage() async {
      CollectionReference post = FirebaseFirestore.instance.collection('Post');
      List<PostdataModel> data = [];

      try {
        QuerySnapshot snapshot = await post.get();
        List<Future<void>> futures = [];

        for (DocumentSnapshot doc in snapshot.docs) {
          futures.add(FirebaseFirestore.instance
              .collection('Users')
              .doc(doc['PostedByUserid'])
              .get()
              .then((snapshot) {
            String? profilepic = snapshot['Profilepic'];
            String? name = snapshot['Name'];

            PostdataModel post = PostdataModel(
              DestinationPlace: doc['Destinationplace'],
              Proffession: doc['Proffession'],
              description: doc['Description'],
              PostedByUserid: doc['PostedByUserid'],
              MobileNo: doc['MobileNo'],
              CurrentPlace: doc['CurrentPlace'],
              Name: name!,
              Profilepic: profilepic!,
              Date: doc['Date'],
              Time: doc['Time'],
            );

            data.add(post);
            data.sort((a, b) => b.Time.compareTo(a.Time));
          }));
        }

        await Future.wait(futures); // Wait for all the async operations to complete

        print('Number of posts: ${data.length}');
        return data;
      } catch (e) {
        print(e.toString());
        return data;
      }
    }
    Future<List<PostdataModel>> DataForProfilePage() async {
      CollectionReference post = FirebaseFirestore.instance.collection('Post');
      List<PostdataModel> data = [];
      try {
        QuerySnapshot snapshot = await post.get();
        final uid = FirebaseAuth.instance.currentUser?.uid;
        for (var doc in snapshot.docs) {
          Map<String, dynamic>? docData = doc.data() as Map<String, dynamic>?;
          if (docData != null && docData['PostedByUserid'] == uid.toString()) {
            print(doc.data());
            PostdataModel Post = PostdataModel(
              DestinationPlace: docData['Destinationplace'],
              Proffession: docData['Proffession'],
              description: docData['Description'],
              PostedByUserid: docData['PostedByUserid'],
              MobileNo: docData['MobileNo'],
              CurrentPlace: docData['CurrentPlace'],
              Name: docData['Name'],
              Profilepic: docData['Profilepic'],
              Date: docData['Date'],
              Time: docData['Time'],
            );
            print(Post);
            data.add(Post);
          }
        }
        return data;
      } catch (e) {
        print(e.toString());
        return data;
      }
    }
    Future<UserDatamodel> Currentuser() async {
      final userdatamodeltemp =UserDatamodel(Name: '', Email: '', currentplace: '', Mobile_no: '', Profilepic: '', Proffession: '');
      final uid=FirebaseAuth.instance.currentUser?.uid;
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .get();
      if(snapshot.exists){
        final userdatamodel=UserDatamodel(Name: snapshot['Name'], Email: snapshot['Email'], currentplace: snapshot['currentplace'], Mobile_no: snapshot['Mobile_no'], Profilepic: snapshot['Profilepic'], Proffession: snapshot['Proffession']);
        return userdatamodel;
      }
      else{
        print('Error');
      }
      return userdatamodeltemp;
    }
    Future<List<NotificationGetDatamodel>> GetNotification()async{
      CollectionReference noti = FirebaseFirestore.instance.collection('Notification');
      List<NotificationGetDatamodel> data = [];
      try {
        QuerySnapshot snapshot = await noti.get();
        List<Future<void>> futures = [];

        for (DocumentSnapshot doc in snapshot.docs) {
          futures.add(FirebaseFirestore.instance
              .collection('Users')
              .doc(doc['PostedByUserid'])
              .get()
              .then((snapshot) {
            String? profilepic = snapshot['Profilepic'];
            String? name = snapshot['Name'];
            final uid=FirebaseAuth.instance.currentUser?.uid;
            NotificationGetDatamodel noti=NotificationGetDatamodel(Name: uid==doc['PostedByUserid']?'You':name!, Date: doc['Date'], Time: doc['Time'], message: doc['message'], Profilepic: profilepic!);
            data.add(noti);
          }));
        }

        await Future.wait(futures); // Wait for all the async operations to complete

        print('Number of posts: ${data.length}');
        return data;
      } catch (e) {
        print(e.toString());
        return data;
      }

  }
  }
