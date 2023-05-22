import 'package:connect2prof/CustomWidgets/Colors.dart';
import 'package:connect2prof/CustomWidgets/PostDesign.dart';
import 'package:connect2prof/UsersData/UsersData.dart';
import 'package:connect2prof/bloc/appbloc.dart';
import 'package:connect2prof/pages/ChatRoom.dart';
import 'package:connect2prof/pages/Dashboard.dart';
import 'package:connect2prof/pages/DetailsPage.dart';
import 'package:connect2prof/pages/Notification.dart';
import 'package:connect2prof/pages/PostPage.dart';
import 'package:connect2prof/pages/ProfilePage.dart';
import 'package:connect2prof/pages/SettingPage.dart';
import 'package:connect2prof/pages/chatInterface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../databaseservices/GetData.dart';
import '../variables.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex=0;
  int notifiy=0;
  final List<Widget> pages = [
    Dashboard(),
    ChatInterface(),
   ProfilePage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    final Height=MediaQuery.of(context).size.height;
    final Width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kPrimary,
      appBar:_selectedIndex==1? AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Messages',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25.0),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(image: NetworkImage('https://img.icons8.com/?size=512&id=15042&format=png',scale: 20)),
            ),
          ],
        ),
      ):_selectedIndex==0?AppBar(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(6.0, 15, 0.0, 10),
          child: Text("MTF",
            maxLines: 1,
            style: TextStyle(
              color: kPrimary,fontFamily: 'MonoRoboto',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),),
        ),

        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(135, 0.0, 0.0, 0.0),
              child: GestureDetector(
                onTap: (){
                  Get.to(()=>PostPage());
                },
                child: ClipOval(child:Icon(Icons.add,color: Colors.black,)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0.0, 0.0, 0.0),
              child: GestureDetector(
                onTap: (){
                  Get.to(()=>NotificationPage());
                },
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 5, 0.0),
                      child: CircleAvatar(
                        radius: 3,
                        backgroundColor: notifiy==0?Colors.transparent:Colors.red,
                      ),
                    ),
                    Icon(Icons.notifications_none,color: Colors.black,),
                  ],
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.grey[100],
        elevation: 0.0,
      ):AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Row(
            children: [
              Icon(
                Icons.arrow_back_ios_new,
                color: kPrimary,
              ),
              Text(
                'Back',
                style: TextStyle(fontSize: 14, color:kPrimary, fontFamily: 'MonoRoboto'),
              ),
            ],
          ),
        ),
        title:Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            GestureDetector(
                onTap: (){
                  Get.to(()=>SettingsPage());
                },
                child: Image(image: NetworkImage('https://img.icons8.com/?size=1x&id=364&format=png',scale: 2))),

          ],
        ),
      ),
      body:
      Container(
          height: Height*0.9,
          width: Width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            color: Colors.grey[100],
          ),
          child:pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimary,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 20,
        selectedIconTheme: IconThemeData(color: Colors.white, size: 25),
         selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        iconSize: 20,
        items: [
          BottomNavigationBarItem(
              label: "Home",
              icon:Icon(Icons.home_outlined,)
          ),
      BottomNavigationBarItem(
          label: "Chat",
          icon:Icon(Icons.messenger_outline,)),
       BottomNavigationBarItem(
         label: "Profile",
           icon:Icon(Icons.person_2_outlined,)),

    ],
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
      ),
    );
  }
}