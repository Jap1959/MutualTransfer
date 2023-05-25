


import 'package:connect2prof/bloc/statesofapp.dart';
import 'package:connect2prof/usermodel/Notificationgetdatamodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../databaseservices/GetData.dart';
import 'events.dart';

class BlocNotification extends Bloc<AppEvent, AppStates> {
  BlocNotification() : super(Pageloading())   {
    on<NotificationLoadEvent>((event, emit) async {
      emit(Pageloading());
    try{
       GetData _getdata=GetData();
       final Noti= await _getdata.GetNotification();
       emit(NotificationLoadedState(Noti));
    }
    catch(e){
      print(e.toString());
    }
  });
        }
  }