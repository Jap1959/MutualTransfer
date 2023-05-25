

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect2prof/UsersData/UsersData.dart';
import 'package:connect2prof/databaseservices/GetData.dart';
import 'package:connect2prof/usermodel/NotificationDatamodel.dart';
import 'package:connect2prof/usermodel/PostdataModel.dart';
import 'package:connect2prof/variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/Homepage.dart';
import '../usermodel/PostUploadDatamodel.dart';
class AddData{
   Future<void> adddata(Map<String,dynamic> Data) async {
      CollectionReference users = FirebaseFirestore.instance.collection('Users');
      try{
        final uid= FirebaseAuth.instance.currentUser?.uid;
        print(Data);
        SharedPreferences prefs=await SharedPreferences.getInstance();
        prefs.setString('Name', Data['Name']);
        prefs.setString('Mobile', Data['Mobile_no']);
          await users.doc(uid).set(Data);
        int? noticount=prefs.getInt('Notification');
        Get.off(()=>Homepage(noticount: noticount!,));
      }
      catch(e){
         print(e.toString());
      }
   }
  Future<void> AddPost(PostUploaddataModel? Post)async {
      CollectionReference post=FirebaseFirestore.instance.collection('Post');
      try{
        SharedPreferences prefs=await SharedPreferences.getInstance();
        String? Name=prefs.getString('Name');
        String? Url=prefs.getString('Url');
        DateTime now = new DateTime.now();
        DateTime date = new DateTime(now.year, now.month, now.day);
          PostdataModel PostFinal=PostdataModel(DestinationPlace: Post!.DestinationPlace, Proffession: Post!.Proffession, description: Post!.description, PostedByUserid: Post!.PostedByUserid, MobileNo: Post.MobileNo, CurrentPlace: Post!.CurrentPlace, Name:Name! , Profilepic:Url!, Date: date.toString(), Time: now.toString());
           await post.add(PostFinal?.toMap());
           int? noticount=prefs.getInt('Notification');
           Get.off(()=>Homepage(noticount: noticount!,));
      }
      catch(e){
        print(e.toString());
      }
  }
  Future<void> Addnotification(String uid)async{

    CollectionReference notification=FirebaseFirestore.instance.collection('Notification');
    try{
      final uid=FirebaseAuth.instance.currentUser?.uid;
      DateTime now = new DateTime.now();
      DateTime date = new DateTime(now.year, now.month, now.day);
      final notify=NotificationDatamodel(PostedByUserid:uid.toString() , Date: date.toString(), Time: now.toString(), message: 'Added a Post');
      notification.add(notify.toMap());
    }
    catch(e){
      print(e.toString());
    }
  }
}