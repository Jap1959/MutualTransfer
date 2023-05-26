



import 'package:connect2prof/bloc/statesofapp.dart';
import 'package:connect2prof/pages/Homepage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../databaseservices/Adddata.dart';
import '../databaseservices/GetData.dart';
import '../pages/Dashboard.dart';
import '../pages/chatInterface.dart';
import '../usermodel/PostdataModel.dart';
import 'events.dart';

class BlocHompage extends Bloc<AppEvent, AppStates> {
  BlocHompage() : super(Pageloading()) {

    on<HomePageDataEvent>((event, emit) async {
      emit(Pageloading());
      try {
        GetData _data = GetData();
        final Post = await _data.DataForHomepage();
        emit(PageLoadedstate(Post));
      }
      catch(e){
        print(e.toString());
      }

    });

    on<SearchEvent>((event,emit) async {

      try{
        GetData _getdata=GetData();
       final List<PostdataModel> user= await _getdata.DataForHomepage();
        List<PostdataModel> results = user.where((user) =>
        user.CurrentPlace.toLowerCase().contains(event.searchvalue.toLowerCase()) ||
            user.Name.toLowerCase().contains(event.searchvalue.toLowerCase()) ||
            user.Proffession.toLowerCase().contains(event.searchvalue.toLowerCase()))
            .toList();
        if(event.searchvalue=="") {
          emit(SearchResultState(user));
        }
        emit(SearchResultState(results));
        print(results.length);
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
        Get.to(()=>Homepage(noticount: noticount!, index: 1,));
      }
      catch(e){
        print(e.toString());
      }
    });

  }
  }