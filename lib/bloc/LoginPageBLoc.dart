



import 'package:connect2prof/bloc/statesofapp.dart';
import 'package:connect2prof/pages/Loginpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../authentication/auth.dart';
import '../pages/Homepage.dart';
import 'events.dart';

class BlocLogin extends Bloc<AppEvent,AppStates>{
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
          SharedPreferences prefs=await SharedPreferences.getInstance();
          int? noticount=prefs.getInt('Notification');
          Get.off(()=>Homepage(noticount: noticount!, index: 0,));
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
    on<ResetPasswordEvent>((event,emit) async {
       emit(ButtonNotPressedState());
       try{
         emit(ButtonPressedState());
           Authentication _auth=Authentication();
              final String status= await _auth.resetPassword(email: event.Email);
              // print(status);

              if(status=='true'){
                Get.snackbar("Message", "Link Send Sucessfully"
                    ,icon: Icon(Icons.check,color: Colors.white,),
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.green
                );
                Authentication _auth=Authentication();
                _auth.signOut();
                Get.offAll(()=>LoginPage());
              }
              else{
                emit(ButtonNotPressedState());
                Get.snackbar("Error", "Email is not registred "
                    ,icon: Icon(Icons.close,color: Colors.white,),
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.red
                );
              }
       }
       catch(e){
         print(e.toString());
       }
    });
  }
}