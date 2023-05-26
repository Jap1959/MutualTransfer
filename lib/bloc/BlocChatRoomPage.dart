


import 'package:connect2prof/bloc/statesofapp.dart';
import 'package:connect2prof/databaseservices/AddchatRoomDetails.dart';
import 'package:connect2prof/databaseservices/GetData.dart';
import 'package:connect2prof/usermodel/MessageDatamodel.dart';
import 'package:connect2prof/usermodel/usermodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'events.dart';

class BlocChatRoom extends  Bloc<AppEvent,AppStates>{
  BlocChatRoom():super(Pageloading()) {
    on<ChatLoadEvent>((event, emit) async {
     emit(Pageloading());
     try{
       GetData _get=GetData();
      List<MessageDatamodel> message=[];
        emit(MessageLoadedSate(message));
     }
     catch(e){
       print(e.toString());
     }
    });
    on<MessageSendEvent>((event, emit) {
      emit(Pageloading());
      try{
        AddchatDetails _adddetails=  AddchatDetails();
        _adddetails.Addmessage(event.message, event.uid);
        ChatLoadEvent();
      }
      catch(e){

      }
    });
  }
  }