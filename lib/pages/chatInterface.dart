


import 'package:connect2prof/CustomWidgets/Colors.dart';
import 'package:connect2prof/CustomWidgets/Serachbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../bloc/appbloc.dart';

class ChatInterface extends StatefulWidget {
  // final String personuid;
  // const ChatInterface({required this.personuid});

  @override
  State<ChatInterface> createState() => _ChatInterfaceState();
}

class _ChatInterfaceState extends State<ChatInterface> {
  @override
  Widget build(BuildContext context) {
    final Height=MediaQuery.of(context).size.height;
    final Width=MediaQuery.of(context).size.width;
    return Container(
        height: Height*0.9,
        width: Width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child:Column(
            children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:SearchBarApp(Hintext: 'Search Name', color: Colors.grey.shade100,),
            ),

              Container(
                height: Height*0.85,
                width: Width,
                child: ListView.builder(
                  itemCount: 15,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Container(
                        height: Height*0.085  ,
                        width: Width,
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 0.5,color: Colors.grey)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage('https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg'),
                              radius: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 160, 0.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text('Name',style: TextStyle(fontFamily: 'MonoRoboto',fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black)),
                               Text('Hii,how are you',style: TextStyle(fontFamily: 'MonoRoboto',fontSize: 15,color: Colors.grey)),

                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Text('02:45',style: TextStyle(fontFamily: 'MonoRoboto',fontSize: 10,color: Colors.grey)),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
    );
  }
}
