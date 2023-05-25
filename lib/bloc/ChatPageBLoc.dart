


import 'package:connect2prof/bloc/events.dart';
import 'package:connect2prof/bloc/statesofapp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocChatPage extends Bloc<ChatLoadEvent,AppStates>{
  BlocChatPage():super(ChatLoadState()){
    on<ChatLoadEvent>((event,emit) async {
      try{
      }
      catch(e){
        print(e.toString());
      }
    });
  }
}


