
import 'package:cloud_firestore/cloud_firestore.dart';

class Addusers{
    String CreateUser(String Collectionname,String uid){
      Map<String,dynamic> user={'uid':uid,};
      try {
        FirebaseFirestore.instance.collection("Users").doc(uid).set(user);
        return 'true';
      }
      catch(e){
        return e.toString();
      }
    }
}