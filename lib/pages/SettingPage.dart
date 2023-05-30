import 'package:connect2prof/CustomWidgets/ButtonAPP.dart';
import 'package:connect2prof/CustomWidgets/Colors.dart';
import 'package:connect2prof/pages/WelcomeScreen.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../authentication/auth.dart';
import '../databaseservices/GetData.dart';
import 'Loginpage.dart';
import 'ProfileEditPage.dart';
import 'ResetPasword.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool clicked=false;
  final items = [
    'Edit Profile',
    'Notification',
    'Change Password',
    'About',
    'Help',
    'Log out',
  ];
  final icons = [
    'https://img.icons8.com/?size=512&id=15042&format=png',
    'https://img.icons8.com/?size=512&id=eMfeVHKyTnkc&format=png',
     'https://img.icons8.com/?size=512&id=82747&format=png',
    'https://img.icons8.com/?size=512&id=HJMT3crrSiU0&format=png',
    'https://img.icons8.com/?size=1x&id=646&format=png',
  ];
bool Notificationoff=false;
  @override
  Widget build(BuildContext context) {
    final Height=MediaQuery.of(context).size.height;
    final Width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        backgroundColor: kPrimary,
        elevation: 0.0,
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 30, 0.0, 0.0),
          child: Container(
            height: Height*0.9,
            width: Width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                height: 600,
                width: double.infinity,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap:() async {
                        GetData _getdata=GetData();
                        final uid=FirebaseAuth.instance.currentUser?.uid;
                        final user=await _getdata.Currentuser(uid.toString());
                        print(user);
                        Get.to(()=>ProfileEditPage(Name: user.Name, Mobile:user.Mobile_no, url:user.Profilepic, Email: user.Email, City: user.currentplace));
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0.0),
                        child: Container(
                          height: Height*0.055,
                          width: Width,
                          child: Row(
                            children: [
                              Image(image: NetworkImage('https://img.icons8.com/?size=512&id=15042&format=png',scale: 20)),
                            Padding(
                           padding: const EdgeInsets.fromLTRB(0.0  , 0.0 , 200, 0.0),
                          child: Text(
                            'Edit Profile',
                             style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'MonoRoboto'),
                           ),
                            ),
                              Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0.0),
                      child: Container(
                        height: Height*0.055,
                        width: Width,
                        child: Row(
                          children: [
                            Image(image: NetworkImage('https://img.icons8.com/?size=512&id=eMfeVHKyTnkc&format=png',scale: 20)),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0.0  , 0.0 , 160, 0.0),
                              child: Text(
                                'Notification',
                                style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'MonoRoboto'),
                              ),
                            ),
                            Switch(
                              // thumb color (round icon)
                              activeColor: Colors.white,
                              activeTrackColor: kPrimary,
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: Colors.grey.shade400,
                              splashRadius: 50.0,
                              // boolean variable value
                              value: Notificationoff,
                              // changes the state of the switch
                              onChanged: (value) => setState(() => Notificationoff = value),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0.0),
                      child: GestureDetector(
                        onTap:() async {
                          Get.to(()=>ResetPasswordPage());
                        },
                        child: Container(
                          height: Height*0.055,
                          width: Width,
                          child: Row(
                            children: [
                              Image(image: NetworkImage('https://img.icons8.com/?size=512&id=82747&format=png',scale: 20)),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0.0  , 0.0 , 135, 0.0),
                                child: Text(
                                  'Change Password',
                                  style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'MonoRoboto'),
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,),
                            ],
                          ),
                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0.0),
                      child: GestureDetector(
                        onTap:() async {

                        },
                        child: Container(
                          height: Height*0.055,
                          width: Width,
                          child: Row(
                            children: [
                              Image(image: NetworkImage('https://img.icons8.com/?size=512&id=HJMT3crrSiU0&format=png',scale: 20)),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0.0  , 0.0 , 245, 0.0),
                                child: Text(
                                  'About',
                                  style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'MonoRoboto'),
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,),
                            ],
                          ),
                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0.0),
                      child: GestureDetector(
                        onTap:() async {

                        },
                        child: Container(
                          height: Height*0.055,
                          width: Width,
                          child: Row(
                            children: [
                              Image(image: NetworkImage('https://img.icons8.com/?size=1x&id=646&format=png',scale: 20)),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0.0  , 0.0 , 280, 0.0),
                                child: Text(
                                  'Help',
                                  style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'MonoRoboto'),
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,),
                            ],
                          ),
                        ),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                onTap: (){
                  Authentication _auth=Authentication();
                  _auth.signOut();
                  Get.offAll(()=>LoginPage());
                },
                child: ButtonAPP(Name: 'Log Out',iconpre:Icons.exit_to_app_outlined ,)),
              ),
                  ],
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}
