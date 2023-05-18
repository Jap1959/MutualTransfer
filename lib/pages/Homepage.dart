import 'package:connect2prof/CustomWidgets/Colors.dart';
import 'package:connect2prof/bloc/appbloc.dart';
import 'package:connect2prof/pages/ChatRoom.dart';
import 'package:connect2prof/pages/Dashboard.dart';
import 'package:connect2prof/pages/DetailsPage.dart';
import 'package:connect2prof/pages/Notification.dart';
import 'package:connect2prof/pages/SettingPage.dart';
import 'package:connect2prof/pages/chatInterface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
    SettingsPage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // if(_selectedIndex==1){
      //   Get.to(()=>ChatInterface());
      // }
      // if(_selectedIndex==2){
      //   Get.to(()=>SettingsPage());
      // }
    });
  }
  @override
  Widget build(BuildContext context) {
    final Height=MediaQuery.of(context).size.height;
    final Width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kPrimary,
      appBar:_selectedIndex==1?AppBar(
        backgroundColor: Colors.white,
        leading: Text('Messages',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30.0),),
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(image: NetworkImage('https://img.icons8.com/?size=512&id=15042&format=png')),
            ),
          ],
        ),
      ):AppBar(
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
                  Get.to(()=>NotificationPage());
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
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body:
      Container(
          height: Height*0.9,
          width: Width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            color: Colors.white,
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
         label: "Settings",
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
