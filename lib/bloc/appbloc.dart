


import 'package:connect2prof/bloc/events.dart';
import 'package:connect2prof/bloc/statesofapp.dart';
import 'package:connect2prof/databaseservices/Adddata.dart';
import 'package:connect2prof/databaseservices/GetData.dart';
import 'package:connect2prof/usermodel/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Blocusage extends Bloc< Userauthenticationevent, AppStates>{
     Blocusage():super(Pageloading()){
       on<Userauthenticationevent>((event,emit)async{
         emit(Pageloading());
         try{

           print(FirebaseAuth.instance.currentUser?.uid);
           if(FirebaseAuth.instance.currentUser?.uid==null) {
             emit(UserlogoutSate());
           }
           else{
             emit(UserloginedState());
           }
         }
         catch(e){
            print("some error occurred ${e.toString()}");
         }
       });
     }
}
class BlocAddData extends Bloc<AdddataEvent, AppStates> {
  BlocAddData() : super(Pageloading()) {
    on<AdddataEvent>((event, emit) async {

       try{
         emit(Pageloading());
         AddData _data=AddData();
         await _data.adddata(event.user.toMap());
           emit(DataUploadedState());

       }
       catch(e){
        emit(Pagerrorstate(e.toString()));
       }

    });
  }
}
class BlocHompage extends Bloc<HomePageDataEvent, AppStates> {
  BlocHompage() : super(Pageloading()) {
    on<HomePageDataEvent>((event, emit) async {
      emit(Pageloading());
      try{
           GetData _data=GetData();
           final List<UserDatamodel> users=await _data.DataForHomepage();
           emit(PageLoadedstate(users));
      }
      catch(e){
        print(e.toString());
      }

    });
  }
}