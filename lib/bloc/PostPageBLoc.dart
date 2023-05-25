


import 'package:connect2prof/bloc/statesofapp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../databaseservices/Adddata.dart';
import 'events.dart';

class BlocPostAdd extends Bloc<AddPostEvent,AppStates>{
  BlocPostAdd():super(ButtonNotPressedState()){
    on<PostLoadEvent>((event,emit) async {
      emit(Pageloading());
      try{
        SharedPreferences prefs= await SharedPreferences.getInstance();
        Object? name=prefs.get('Name');
        Object? url=prefs.get('Url');
        Object? Mobile=prefs.get('Mobile');
        emit(PagePostLoad(name.toString(), url.toString(), Mobile.toString()));
      }
      catch(e){
        print(e.toString());
      }
    });
    on<AddPostEvent>((event,emit) async {
      emit(ButtonPressedState());
      try{
        emit(ButtonPressedState());
        AddData _AddData=AddData();
        _AddData.AddPost(event!.Post);
        _AddData.Addnotification(event!.Post!.PostedByUserid);
        SharedPreferences prefs=await SharedPreferences.getInstance();
        prefs.setInt('Notification', 1);
      }
      catch(e){
        print(e.toString());
      }
    });
  }

}