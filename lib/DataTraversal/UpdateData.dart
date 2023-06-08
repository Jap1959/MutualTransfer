


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdateData{
  Future<void>  UpdateProfile(Map<String,dynamic> Data) async {
    final uid=FirebaseAuth.instance.currentUser?.uid;
    CollectionReference collection = await FirebaseFirestore.instance.collection('Users');
    DocumentReference document = collection.doc(uid);

    document.update({
      'Name': Data['Name'],
      'Mobile_no': Data['Mobile_no'],
      'Profilepic':Data['Profilepic'],
      'currentplace':Data['currentplace'],
      'Proffession':Data['Proffession'],
      // Add more fields to update and their new values
    }).then((value) {
    }).catchError((error) {
      print('Failed to update document: $error');
    });

  }
}