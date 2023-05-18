

import 'package:connect2prof/pages/chatInterface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../authentication/auth.dart';

class Chatroom extends StatefulWidget {
  const Chatroom({Key? key}) : super(key: key);

  @override
  State<Chatroom> createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  final Items=[
    'Person1',
    'Person2',
  'Person3',
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
              child: Icon(Icons.messenger_rounded,color: Colors.black,),
            ),
            Text('Chat',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30.0),),
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
                   Get.to(()=>ChatInterface());
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
