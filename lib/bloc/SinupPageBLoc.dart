


import 'package:connect2prof/bloc/statesofapp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../authentication/auth.dart';
import '../pages/DetailsPage.dart';
import 'events.dart';

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
          Get.offAll(() => DetailsPage());
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