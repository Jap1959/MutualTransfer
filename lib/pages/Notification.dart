


import 'package:connect2prof/CustomWidgets/Colors.dart';
import 'package:connect2prof/CustomWidgets/NotificationTiles.dart';
import 'package:connect2prof/bloc/NotificationBLoc.dart';
import 'package:connect2prof/pages/Homepage.dart';
import 'package:connect2prof/usermodel/Notificationgetdatamodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/events.dart';
import '../bloc/statesofapp.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  BlocNotification _blocNotification = BlocNotification();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _blocNotification.add(NotificationLoadEvent());
  }

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

    return BlocBuilder<BlocNotification, AppStates>(
        bloc: _blocNotification,
        builder: (context, state) {
          if (state is Pageloading) {
            return Scaffold(
              backgroundColor: kPrimary,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs=await SharedPreferences.getInstance();
                     int? noticount=prefs.getInt('Notification');
                      Get.to(()=>Homepage(noticount: noticount!));
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(7.0, 0.0, 0.0, 0.0),
                      child: Center(
                          child: Icon(Icons.arrow_back_ios, color: Colors.white)),
                    ),
                  ),
                ),
                elevation: 0.0,
                title: Text('Notification', style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0),),
              ),
              body: Container(
                height: Height * 0.9,
                width: Width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                    color: Colors.white
                ),
                child: Center(
                  child: CircularProgressIndicator(
                    color: kPrimary,
                  ),
                ),
              ),
            );
          }
          if (state is NotificationLoadedState) {
            List<NotificationGetDatamodel> Noti = state.notifications;
            return Scaffold(
              backgroundColor: kPrimary,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs=await SharedPreferences.getInstance();
                      int? noticount=prefs.getInt('Notification');
                      Get.to(()=>Homepage(noticount: noticount!));
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(7.0, 0.0, 0.0, 0.0),
                      child: Center(
                          child: Icon(Icons.arrow_back_ios, color: Colors.white)),
                    ),
                  ),
                ),
                elevation: 0.0,
                title: Text('Notification', style: TextStyle(color: Colors.white,
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
                  child: Noti.length==0?Center(child:Text('No Notifications',style: TextStyle(fontFamily: 'MonoRoboto',fontSize: 20,color: kPrimary)) ,):Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: ListView.builder(
                        itemCount: Noti.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              NotificationTiles(title: Noti[index].Name,
                                  subtitle: Noti[index].message,
                                  url: Noti[index].Profilepic),
                              Container(
                                height: 0.5,
                                width: Width,
                                color: Colors.grey[400],
                              ),
                            ],
                          );
                        }
                    ),
                  ),
                ),
              ),
            );
          }
         return Container();
        });
  }
}
