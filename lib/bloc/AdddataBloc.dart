



import 'package:connect2prof/bloc/statesofapp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../DataTraversal/UpdateData.dart';
import '../databaseservices/Adddata.dart';
import '../databaseservices/StoreImageFile.dart';
import '../pages/Homepage.dart';
import 'events.dart';

class BlocAddData extends Bloc<AdddataEvent, AppStates> {
  BlocAddData() : super(Pageloading()) {
    on<AdddataEvent>((event, emit) async {

      try{
        emit(Pageloading());
        AddData _data=AddData();
        await _data.adddata(event.user!.toMap());
        SharedPreferences prefs=await SharedPreferences.getInstance();
        int? noticount=prefs.getInt('Notification');
        // emit(DataUploadedState(noticount!));
        Get.off(() => Homepage(
          noticount: noticount!,
          index: 0,
        ));
        emit(DataUploadedState(noticount!));

      }
      catch(e){
        emit(Pagerrorstate(e.toString()));
      }

    });
    on<ProfileUploadEvent>((event, emit) async {
      try{
        emit(UploadStartState());
        Storage store=Storage();
        final url=await store.upload(event.path,event.filename);
        if(url!=null){
          SharedPreferences prefs=await SharedPreferences.getInstance();
          prefs.setString('Url', url.toString());
          emit(UploadCompleted(url.toString()));
        }
      }
      catch(e){
        emit(Pagerrorstate(e.toString()));
      }

    });
    on<ProfileUpdateEvent>((event,emit) async {
      try{
        emit(Pageloading());
        UpdateData _data=UpdateData();
        await _data.UpdateProfile(event.user!.toMap());
        SharedPreferences prefs=await SharedPreferences.getInstance();
        int? noticount=prefs.getInt('Notification');
        emit(DataUploadedState(noticount!));

      }
      catch(e){
        print(e.toString());
      }
    });

  }
}