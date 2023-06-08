


import 'package:connect2prof/CustomWidgets/ButtonAPP.dart';
import 'package:connect2prof/CustomWidgets/Colors.dart';
import 'package:connect2prof/CustomWidgets/Textfield.dart';
import 'package:connect2prof/bloc/LoginPageBLoc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../CustomWidgets/LoadingButton.dart';
import '../bloc/events.dart';
import '../bloc/statesofapp.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  BlocLogin _blocLogin = BlocLogin();
  TextEditingController Email=new TextEditingController();

  @override

  @override
  Widget build(BuildContext context) {
    final Height = MediaQuery
        .of(context)
        .size
        .height;
    final Width = MediaQuery
        .of(context)
        .size
        .width;

    return BlocBuilder<BlocLogin, AppStates>(
        bloc: _blocLogin,
        builder: (context, state) {

            return Scaffold(
              backgroundColor: kPrimary,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(7.0, 0.0, 0.0, 0.0),
                      child: Center(
                          child: Icon(Icons.arrow_back_ios, color: Colors.white)),
                    ),
                  ),
                ),
                elevation: 0.0,
                title: Text('ResetPassword', style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0),),
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  height: Height * 0.9,
                  width: Width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                      color: Colors.white
                  ),
                  child:Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 100,left: 20,right: 20),
                        child: Text('Reset your Password by Entering your Email', style: TextStyle(color: Colors.black,
                            fontSize: 20.0),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
                        child: TextfieldApp(Email: Email, HintText: 'Enter your Email', color: Colors.grey.shade100,icon: Icons.email_rounded,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
                        child: state is ButtonNotPressedState?GestureDetector(
                            onTap: (){
                              if(EmailValidator.validate(Email.text.toString())) {
                                _blocLogin.add(ResetPasswordEvent(
                                    Email.text.toString()));
                              }
                              else{
                                Get.snackbar("Error", "Enter a valid Email"
                                    ,icon: Icon(Icons.close,color: Colors.white,),
                                    snackPosition: SnackPosition.TOP,
                                    backgroundColor: Colors.red
                                );
                              }
                            },
                            child: ButtonAPP(Name: 'Send Link',icon: Icons.arrow_forward,)):LoadingButton(),
                      ),
                    ],
                  ),
                  ),
              ),
              );
        });
  }
}
