
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect2prof/usermodel/PostdataModel.dart';
import 'package:connect2prof/usermodel/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class GetData{

  Future<List<PostdataModel>> DataForHomepage() async {
      CollectionReference post=FirebaseFirestore.instance.collection('Post');
      List<PostdataModel> data = [];
      try {
        QuerySnapshot snapshot = await post.get();
        snapshot.docs.forEach((DocumentSnapshot doc) async {
          Map<String, dynamic>? docData = doc.data() as Map<String, dynamic>?;
          if(docData!=null) {
            print(doc.data());
            DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(docData['PostedByUserid']).get();
            PostdataModel Post=PostdataModel(DestinationPlace: docData['Destinationplace'], Proffession: docData['Proffession'], description: docData['Description'], PostedByUserid: docData['PostedByUserid'], MobileNo: docData['MobileNo'], CurrentPlace: docData['CurrentPlace'],Name:snapshot['Name'],Profilepic:snapshot['Profilepic ']);
            data.add(Post);
          }
        });
        return data;
      }
      catch(e){
        print(e.toString());
        return data;
      }

  }
  Future<Map<String,dynamic>?>CurrentUser() async {
    final uid=FirebaseAuth.instance.currentUser?.uid;
  DocumentReference user=FirebaseFirestore.instance.collection('Users').doc(uid);

    try {
          DocumentSnapshot snapshot=await user.get();
          Map<String, dynamic>? userData = snapshot.data() as Map<String, dynamic>?;
          if (userData != null) {
             Map<String,dynamic> user={'Name': userData['Name'],
               'Mobile':userData['Mobile_no'],
               'Profilepic':userData['Profilepic'],};
            return user;
          }
    }
    catch(e){
      print(e.toString());

    }
  }
}
