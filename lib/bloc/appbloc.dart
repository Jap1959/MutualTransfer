


import 'package:connect2prof/UsersData/UsersData.dart';
import 'package:connect2prof/bloc/events.dart';
import 'package:connect2prof/bloc/statesofapp.dart';
import 'package:connect2prof/databaseservices/Adddata.dart';
import 'package:connect2prof/databaseservices/GetData.dart';
import 'package:connect2prof/pages/DetailsPage.dart';
import 'package:connect2prof/pages/Homepage.dart';
import 'package:connect2prof/usermodel/usermodel.dart';
import 'package:connect2prof/variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../authentication/auth.dart';
import '../databaseservices/StoreImageFile.dart';

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
             GetData _getdata=GetData();
             final user=await _getdata.CurrentUser();
             currentuser=UsersData(Mobile: user?['Mobile'], Name: user?['Name'], profilepic: user?['Profilepic']);
             print('--------------------------------------->${currentuser.Name}');
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
         await _data.adddata(event.user!.toMap());
           emit(DataUploadedState());

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
          emit(UploadCompleted(url.toString()));
        }
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
      try {
        GetData _data = GetData();
        final Post = await _data.DataForHomepage();
        emit(PageLoadedstate(Post));
      }
      catch(e){
           print(e.toString());
      }

    });
  }
}
class BlocLogin extends Bloc<LoginPageEvent,AppStates>{
    BlocLogin():super(ButtonNotPressedState()){
      on<LoginPageEvent>((event,emit) async {
        emit(ButtonNotPressedState());
        try {
          emit(ButtonPressedState());
          Authentication _auth = Authentication();
           final User= await _auth.signInWithEmailAndPassword(
                event.Email.toString(), event.password.toString());
           if(User!='[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.') {
             emit(LoginSucessState());

             Get.offAll(()=>Homepage());
           }
           else{
             if(User=='[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.'){
               emit(ButtonNotPressedState());
               Get.snackbar("Error", "User Not registered"
                   ,icon: Icon(Icons.close,color: Colors.white,),
                   snackPosition: SnackPosition.TOP,
                   backgroundColor: Colors.red
               );
             }
           }
        }
        catch(e){
           String Error='';
          if(e.toString()=='There is no user record corresponding to this identifier. The user may have been deleted'){
            Error='User not Registered Singup to Continue';
          }
          emit(LoginUnsucessfullState(Error));
          print(e.toString());
        }
      });
}
}
class BlocSingUp extends Bloc<SinupPageEvent,AppStates>{
   BlocSingUp():super(ButtonNotPressedState())  {
     on<SinupPageEvent>((event,emit) async {
       emit(ButtonNotPressedState());
       try{
         emit(ButtonPressedState());
         Authentication _authentication = Authentication();
         final Credential = await _authentication
             .registerWithEmailAndPassword(
             event.Email.toString(), event.password.toString());
         if(Credential!=null){
           Get.snackbar(
             "Message", "Account created sucessfully",
             icon: Icon(Icons.check, color: Colors.white),
             snackPosition: SnackPosition.TOP,
             backgroundColor: Colors.green,
           );
           Get.off(() => DetailsPage());
         }
         else{
           emit(ButtonNotPressedState());
         }
       }
       catch(e){
         print(e.toString());
       }
         });

         }
}
class BlocPostAdd extends Bloc<AddPostEvent,AppStates>{
  BlocPostAdd():super(ButtonNotPressedState()){
    on<AddPostEvent>((event,emit){
       emit(ButtonPressedState());
       try{
         emit(ButtonPressedState());
           AddData _AddData=AddData();
           _AddData.AddPost(event.Post);
       }
       catch(e){
         print(e.toString());
       }
    });
  }

}
