

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../pages/Homepage.dart';

class AddData{
   Future<void> adddata(Map<String,dynamic> Data) async {
      CollectionReference users = FirebaseFirestore.instance.collection('Users');
      try{
        final uid= FirebaseAuth.instance.currentUser?.uid;
          await users.doc(uid).set(Data);
        Get.offAll(()=>Homepage());
      }
      catch(e){
         print(e.toString());
      }
   }
   void Addprofile(String url){
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      final uid=FirebaseAuth.instance.currentUser?.uid;
      final data={'profile':url};
      try {
         print('HIII--------------->');
         users.doc(uid).set(data);
      }
      catch(e){
         print(e.toString());
      }
   }
}