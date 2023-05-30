


import 'package:connect2prof/bloc/statesofapp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../databaseservices/Adddata.dart';
import '../databaseservices/GetData.dart';
import '../pages/Homepage.dart';
import 'events.dart';

class ProfileLoad extends Bloc<AppEvent,AppStates>{
  ProfileLoad():super(Pageloading()){
    on<ProfilePageEvent>((event, emit) async {
      emit(Pageloading());
      try{
        emit(Pageloading());
        GetData _get=GetData();
        final user=await _get.Currentuser(event.uid.toString());
        GetData _getdata=GetData();
        final Post= await _getdata.DataForProfilePage(event.uid.toString());
        emit(ProfilePageLoadedstate(Post,user));
      }
      catch(e){
        print(e.toString());
      }
    });
    on<MessageEvent>((event,emit) async {
      emit(ButtonPressedState());
      try{
        AddData _adddata=AddData();
        _adddata.AddChatroom(event.uid);
        SharedPreferences prefs=await SharedPreferences.getInstance();
        int? noticount=prefs.getInt('Notification');
        Get.to(()=>Homepage(noticount: noticount==null?0:noticount, index: 1,));
      }
      catch(e){
        print(e.toString());
      }
    });
  }
}