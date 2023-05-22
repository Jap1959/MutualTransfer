

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect2prof/UsersData/UsersData.dart';
import 'package:connect2prof/databaseservices/GetData.dart';
import 'package:connect2prof/usermodel/PostdataModel.dart';
import 'package:connect2prof/variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../pages/Homepage.dart';
import '../usermodel/PostUploadDatamodel.dart';

class AddData{
   Future<void> adddata(Map<String,dynamic> Data) async {
      CollectionReference users = FirebaseFirestore.instance.collection('Users');
      try{
        final uid= FirebaseAuth.instance.currentUser?.uid;
        GetData  _getdata=GetData();
        final user=_getdata.CurrentUser();
        print(Data);
        currentuser=UsersData(Mobile: Data['Mobile_no'], Name: Data['Name'], profilepic: Data['Profilepic']);
          await users.doc(uid).set(Data);
        Get.offAll(()=>Homepage());
      }
      catch(e){
         print(e.toString());
      }
   }
  Future<void> AddPost(PostUploaddataModel Post)async {
      CollectionReference post=FirebaseFirestore.instance.collection('Post');
      try{
           await post.add(Post.toMap());
           Get.off(()=>Homepage());
      }
      catch(e){
        print(e.toString());
      }
  }
}