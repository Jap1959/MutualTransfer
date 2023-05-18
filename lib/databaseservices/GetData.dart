
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect2prof/usermodel/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class GetData{

  Future<List<UserDatamodel>> DataForHomepage() async {
      CollectionReference users=FirebaseFirestore.instance.collection('Users');
      List<UserDatamodel> data = [];
      try {
        QuerySnapshot snapshot = await users.get();
        snapshot.docs.forEach((DocumentSnapshot doc) {
          Map<String, dynamic>? docData = doc.data() as Map<String, dynamic>?;
          if(docData!=null) {
            print(doc.data());
            UserDatamodel user = UserDatamodel(
                Name: docData['Name'], Email: docData['Email'], currentplace: docData['currentplace'],
                Mobile_no: docData['Mobile_no'], Profilepic: docData['Profilepic']);
            data.add(user);
          }
        });
        return data;
      }
      catch(e){
        print(e.toString());
        return data;
      }

  }
  Future<UserDatamodel?> CurrentUser() async {
    final uid=FirebaseAuth.instance.currentUser?.uid;
  DocumentReference user=FirebaseFirestore.instance.collection('Users').doc(uid);

    try {
          DocumentSnapshot snapshot=await user.get();
          Map<String, dynamic>? userData = snapshot.data() as Map<String, dynamic>?;
          if (userData != null) {

            return UserDatamodel(Name: userData['Name'], Email: userData['Email'], currentplace: userData['currentplace'], Mobile_no: userData['Mobile_no'], Profilepic: userData['Profilepic']);
          }
    }
    catch(e){
      print(e.toString());

    }

  }
}
