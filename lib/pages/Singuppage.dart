
import 'package:connect2prof/CustomWidgets/ButtonAPP.dart';
import 'package:connect2prof/CustomWidgets/Colors.dart';
import 'package:connect2prof/CustomWidgets/LoadingButton.dart';
import 'package:connect2prof/CustomWidgets/Textfield.dart';
import 'package:connect2prof/CustomWidgets/TextfieldPassword.dart';
import 'package:connect2prof/bloc/ChatPageBLoc.dart';
import 'package:connect2prof/bloc/events.dart';
import 'package:connect2prof/pages/DetailsPage.dart';
import 'package:connect2prof/pages/Loginpage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../authentication/auth.dart';
import '../bloc/SinupPageBLoc.dart';
import '../bloc/statesofapp.dart';

class SingupPage extends StatefulWidget {
  const SingupPage({Key? key}) : super(key: key);

  @override
  State<SingupPage> createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  bool passwordVisible = false;
  bool passwordVisiblemain = false;
  late final TextEditingController Email= new TextEditingController();
  late final TextEditingController Pass=new TextEditingController();
  late final TextEditingController Repass=new TextEditingController();
  BlocSingUp _blocSingUp=BlocSingUp();

  @override
  Widget build(BuildContext context) {
    final Height=MediaQuery.of(context).size.height;
    final Width=MediaQuery.of(context).size.width;
    return BlocBuilder<BlocSingUp,AppStates>(
        bloc: _blocSingUp,
        builder: (context,state)
    {
      return Scaffold(
        backgroundColor: kPrimary,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Center(child: Text('Create Account', style: TextStyle(
              fontFamily: 'MonoRoboto',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white),)),
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios_new, color: Colors.white,),
                Text('Back', style: TextStyle(fontFamily: 'MonoRoboto',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 70, 0.0, 0.0),
          child: Container(
            height: Height,
            width: Width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),


            ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Let's Get Started", style: TextStyle(
                      fontFamily: 'RobotoMono',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                      child: TextfieldApp(Email: Email,
                        HintText: "Enter Your Email",
                        icon: Icons.email_outlined,
                        color: Colors.grey.shade100,),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                      child: TextfieldPassword(
                        HintText: "Enter Your Password", Password: Pass,),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                      child: TextfieldPassword(
                        HintText: "Enter Password Again", Password: Repass,),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 20, 10, 10),
                      child: state is ButtonPressedState ?LoadingButton():GestureDetector(onTap: () async {
                        String RePassword = Repass.text.toString();
                        String Password = Pass.text.toString();
                        if(RePassword==Password) {
                          _blocSingUp.add(SinupPageEvent(
                              Email.text.toString(), Pass.text.toString()));
                        }
                        else{
                          Get.snackbar(
                            "Error", "Password Do not match",
                            icon: Icon(Icons.close, color: Colors.white),
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.red,
                          );
                        }
                      },
                        child:ButtonAPP(
                          Name: "Create Account", icon: Icons.arrow_forward,),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        const Text("Already have account?", style: TextStyle(
                          fontFamily: 'RobotoMono',
                          fontSize: 15,
                          color: Colors.black,
                        ),),
                        TextButton(onPressed: () {
                          Get.to(LoginPage());
                        }, child: const Text("Login", style: TextStyle(
                          fontFamily: 'RobotoMono',
                          fontSize: 15,
                          color: Colors.teal,
                        ),),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 400,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black)
                        ),
                        child: TextButton(onPressed: () {}, child: Row(
                          children: [
                            Image.network(
                                'http://pngimg.com/uploads/google/google_PNG19635.png',
                                fit: BoxFit.cover
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Signup With Google', style: TextStyle(
                                fontFamily: 'RobotoMono',
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              ),
                            ),
                          ],
                        ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });

  }
}
