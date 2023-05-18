

import 'dart:io';

import 'package:connect2prof/databaseservices/Adddata.dart';
import 'package:connect2prof/usermodel/usermodel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_core/src/get_main.dart';

class Storage{
  final FirebaseStorage storage=FirebaseStorage.instance;
  Future<String> upload(String filepath, String filename) async {
    File file=File(filepath);
    try{
      await storage.ref('$filename').putFile(file);
      String downloadURL = await storage.ref(filename).getDownloadURL();
      return downloadURL;
    }
    catch(e){
      return e.toString();
    }
}
}