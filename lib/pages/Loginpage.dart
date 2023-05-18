
import 'package:connect2prof/CustomWidgets/ButtonAPP.dart';
import 'package:connect2prof/CustomWidgets/Colors.dart';
import 'package:connect2prof/CustomWidgets/TextfieldPassword.dart';
import 'package:connect2prof/authentication/auth.dart';
import 'package:connect2prof/pages/Homepage.dart';
import 'package:connect2prof/pages/Singuppage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../CustomWidgets/Textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passwordVisiblemain=false;
  late  final TextEditingController Email=new TextEditingController();
  late final TextEditingController Password=new TextEditingController();
  FocusNode Passwordfocus=FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordVisiblemain=true;
  }
  Widget build(BuildContext context) {
    final Height=MediaQuery.of(context).size.height;
    final Width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Center(child: Text('Login To Your Account',style: TextStyle(fontFamily: 'MonoRoboto',fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),)),
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Row(
            children: [
              Icon(Icons.arrow_back_ios_new,color: Colors.white,),
              Text('Back',style: TextStyle(fontFamily: 'MonoRoboto',fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white),),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 25, 0.0, 0.0),
        child: Container(
          height: Height,
          width: Width,
          decoration: BoxDecoration(
            color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight:Radius.circular(40.0),
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

                  Text('Welcome back' ,style: TextStyle(
                    fontFamily:'RobotoMono',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextfieldApp(Email: Email, HintText: 'Enter your Email', icon: Icons.email_outlined),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextfieldPassword(Password: Password, HintText: "Enter your Password"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(onTap: () async {
                      Authentication _auth=Authentication();
                      final status= await _auth.signInWithEmailAndPassword(Email.text.toString(), Password.text.toString());
                      if(status!=null) {
                        Get.to(() => Homepage());
                      }
                      else{
                        Get.snackbar("Error","Enter valid Details",
                          icon: Icon(Icons.close,color: Colors.white,),
                          backgroundColor: Colors.red,
                        );
                      }
                    }, child:ButtonAPP(Name: 'Login',icon: Icons.arrow_forward,),
                    ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Don't have account?",style: TextStyle(
                        fontFamily:'RobotoMono',
                        fontSize: 15,
                        color: Colors.black,
                      ),),
                      TextButton(onPressed: (){
                         Get.to(SingupPage());
                      }, child: Text("Singup",style: TextStyle(
                        fontFamily:'RobotoMono',
                        fontSize: 15,
                        color: kPrimary,
                      ),),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                      Authentication _auth=Authentication();
                      final user =await _auth.signInWithGoogle();
                      if(user!=null){
                        Get.snackbar("Message", "Singined in Successfully",backgroundColor: Colors.green,icon: Icon(Icons.check,color: Colors.white,));
                        Get.offAll(()=>Homepage());
                      }
                      },
                      child: Container(
                        width: 400,
                        height: 50,
                        child:Row(
                          children: [
                            Image.network(
                                'http://pngimg.com/uploads/google/google_PNG19635.png',
                                fit:BoxFit.cover
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                              child: Text('Login With Google',style: TextStyle(
                                fontFamily:'RobotoMono',
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black)
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
  }
}
