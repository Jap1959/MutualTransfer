


import 'package:connect2prof/bloc/statesofapp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../databaseservices/GetData.dart';
import 'events.dart';

class ProfileLoad extends Bloc<ProfilePageEvent,AppStates>{
  ProfileLoad():super(Pageloading()){
    on<ProfilePageEvent>((event, emit) async {
      emit(Pageloading());
      try{
        emit(Pageloading());
        GetData _get=GetData();
        final user=await _get.Currentuser();
        GetData _getdata=GetData();
        final Post= await _getdata.DataForProfilePage();
        emit(ProfilePageLoadedstate(Post,user));
      }
      catch(e){
        print(e.toString());
      }
    });
  }
}