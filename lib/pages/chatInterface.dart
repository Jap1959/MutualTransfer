


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
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Container(
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
              child: Container(
              width: 550,
              height:45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[100],
              ),
              child: TextFormField(
                cursorColor: Colors.black,
                enableSuggestions: true,
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(color:Colors.grey[500]),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8),
                    child: Icon(
                     Icons.search,
                      color: Colors.black,
                    ),
                  ),
                  suffixIcon: Icon(Icons.mic,color: Colors.black,),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder:OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusColor: Colors.black,
                ),
              ),
          ),
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
      ),
    );
  }
}
