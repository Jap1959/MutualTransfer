


import 'package:connect2prof/bloc/statesofapp.dart';
import 'package:connect2prof/databaseservices/AddchatRoomDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'events.dart';

class Blocusage extends Bloc< Userauthenticationevent, AppStates>{
  Blocusage():super(Pageloading()){
    on<Userauthenticationevent>((event,emit)async{
      emit(Pageloading());
      try {
        SharedPreferences prefs=await SharedPreferences.getInstance();
        int noti=prefs.getInt('Notification') ?? 0;
        List<Future<void>> futures = [];
        AddchatDetails _chat=AddchatDetails();
        print(FirebaseAuth.instance.currentUser?.uid);
        await Future.wait(futures);
        if (FirebaseAuth.instance.currentUser?.uid == null) {
          emit(UserlogoutSate());
        }
        else {
          emit(UserloginedState(noti));
        }
      }
      catch(e){
        print("some error occurred ${e.toString()}");
      }
    });
  }
}