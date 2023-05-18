


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
 final Items=[
    'Notification 1',
  'Notification 2',
  'Notification 3',
  'Notification 4',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: (){
              Get.back();
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.fromLTRB(7.0, 0.0, 0.0, 0.0),
                child: Center(child: Icon(Icons.arrow_back_ios,color: Colors.black)),
              ),
            ),
          ),
        ),
        elevation: 0.0,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.notifications,color: Colors.black,),
            ),
            Text('Notification',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30.0),),
          ],
        ),
      ),
      body: Container(
        height: 600,
        width: double.infinity,
        child: ListView.builder(
          itemCount: Items.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: GestureDetector(
                onTap: (){
                },
                child: Container(
                  width: 1000,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            Items[index],
                            style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'MonoRoboto'),
                          ),
                        ),
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('1'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
