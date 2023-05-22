import 'package:connect2prof/CustomWidgets/ButtonAPP.dart';
import 'package:connect2prof/CustomWidgets/Colors.dart';
import 'package:connect2prof/pages/WelcomeScreen.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../authentication/auth.dart';
import 'Loginpage.dart';


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
      body: Padding(
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 40, 0.0, 0.0),
              child: Column(
                children: [
                  Container(
                    height: 600,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {

                        return ListTile(
                          title:  index==items.length-1? Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: GestureDetector(
                              onTap: (){
                                Authentication _auth=Authentication();
                                _auth.signOut();
                                Get.offAll(()=>WelcomeScrenn());
                              },
                                child: ButtonAPP(Name: 'Log Out',iconpre:Icons.exit_to_app_outlined ,)),
                          ) :Container(
                              width: 1000,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  Image(image: NetworkImage(icons[index])),
                                    index==0?Padding(
                                      padding: const EdgeInsets.fromLTRB(0.0  , 0.0 , 150, 0.0),
                                      child: Text(
                                        items[index],
                                        style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'MonoRoboto'),
                                      ),
                                    ):index==1?Padding(
                                      padding: const EdgeInsets.fromLTRB(0.0  , 0.0 , 120, 0.0),
                                      child: Text(
                                        items[index],
                                        style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'MonoRoboto'),
                                      ),
                                    ):index==2?Padding(
                                      padding: const EdgeInsets.fromLTRB(0.0  , 0.0 , 100, 0.0),
                                      child: Text(
                                        items[index],
                                        style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'MonoRoboto'),
                                      ),
                                    ):Padding(
                                      padding: const EdgeInsets.fromLTRB(0.0  , 0.0 , 200, 0.0),
                                      child: Text(
                                        items[index],
                                        style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'MonoRoboto'),
                                      ),
                                    ),
                                    index==1?Switch(
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
                                    ):Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,),
                                  ],
                                ),
                              ),
                            ),
                        );
                      },
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
