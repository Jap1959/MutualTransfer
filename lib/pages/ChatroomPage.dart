


import 'package:connect2prof/CustomWidgets/Textfield.dart';
import 'package:connect2prof/bloc/BlocChatRoomPage.dart';
import 'package:connect2prof/bloc/events.dart';
import 'package:connect2prof/usermodel/MessageDatamodel.dart';
import 'package:connect2prof/usermodel/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../CustomWidgets/Colors.dart';
import '../bloc/statesofapp.dart';

class ChatRoomPage extends StatefulWidget {
 ChatRoomPage({required this.Proffesion,required this.url,required this.Name,required this.uid});
  String Name;String Proffesion;
  String url;
  String uid;

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  BlocChatRoom _blocChatRoom=BlocChatRoom();
  TextEditingController messagecontroller=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _blocChatRoom.add(ChatLoadEvent());
  }
  @override
  Widget build(BuildContext context) {
    final Height=MediaQuery.of(context).size.height;
    final Width=MediaQuery.of(context).size.width;
    return BlocBuilder<BlocChatRoom, AppStates>(
        bloc: _blocChatRoom,
        builder: (context, state) {
          if(state is MessageLoadedSate) {
            List<MessageDatamodel> results=state.message;
            return Scaffold(
              backgroundColor: kPrimary,
                appBar: AppBar(
                  backgroundColor: kPrimary,
                  elevation: 0.0,
                  title:Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey[100],
                        backgroundImage: NetworkImage(
                            widget.url),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment
                              .start,
                          children: [
                            Text(
                              widget.Name,
                              style: TextStyle(fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: 'MonoRoboto'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                widget.Proffesion,
                                style: TextStyle(fontSize: 10,
                                    color: Colors.white,
                                    fontFamily: 'MonoRoboto'),
                              ),
                            ),
                          ],
                        ),

                      ),
                    ],
                  ) ,
                ),
                body:
                SingleChildScrollView(
                  child: Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 8, 0.0, 0.0),
                        child: Container(
                            height: Height*0.9,
                            width: Width,
                              color: Colors.white,
                            child:ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 2,
                                itemBuilder: (context,int index){
                               return index==1?Row(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 children: [
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Container(
                                       width: Width*0.85,
                                       child: TextfieldApp(Email: messagecontroller, HintText: 'Add Message', color: Colors.white,
                                       ),
                                     ),
                                   ),
                                   GestureDetector(
                                     onTap:(){
                                       final uid=FirebaseAuth.instance.currentUser?.uid;
                                       String Time=DateTime.now().millisecondsSinceEpoch.toString();
                                       MessageDatamodel message=MessageDatamodel(PostedByUserid:uid.toString() , Date:Time , message: messagecontroller.text.toString());
                                      _blocChatRoom.add(MessageSendEvent(message,widget.uid));
                                  },
                                       child: Icon(Icons.send_rounded,color: kPrimary,)),
                                 ],
                               ):Container(
                                 height: Height*.82,
                                   width: Checkbox.width,
                                   child:ListView.builder(
                                     itemCount:results.length ,
                                       itemBuilder: (context,int index){
                                        return Container(

                                        );
                                   })
                               );
                        }),
                        ),
                      ),
                    ],
                  ),
                ),
            );
          }
          return Container();
        });
  }
}
// Row(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Container(
// width: Width*0.86,
// child: TextfieldApp(Email: message, HintText: 'Add Message', color: Colors.white,
//
// ),
// ),
// ),
// Icon(Icons.send_rounded,color: kPrimary,),
// ],
// )