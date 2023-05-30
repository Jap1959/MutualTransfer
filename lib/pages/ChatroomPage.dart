import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect2prof/CustomWidgets/Textfield.dart';
import 'package:connect2prof/UsersData/UsersData.dart';
import 'package:connect2prof/bloc/BlocChatRoomPage.dart';
import 'package:connect2prof/bloc/events.dart';
import 'package:connect2prof/databaseservices/AddchatRoomDetails.dart';
import 'package:connect2prof/databaseservices/GetChatData.dart';
import 'package:connect2prof/usermodel/MessageDatamodel.dart';
import 'package:connect2prof/usermodel/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../CustomWidgets/Colors.dart';
import '../bloc/statesofapp.dart';

class ChatRoomPage extends StatefulWidget {
  ChatRoomPage(
      {required this.Proffesion,
      required this.url,
      required this.Name,
      required this.uid,required this.reuid});
  String Name;
  String Proffesion;
  String url;
  String uid;
  String reuid;

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  late TextEditingController messagecontroller;
  late FocusNode _messageFocusNode;
  List<MessageDatamodel> _list=[];

  GetChatData _chat = GetChatData();
  @override
  void initState() {
    super.initState();
    messagecontroller = TextEditingController();
    _messageFocusNode = FocusNode();
  }

  @override
  void dispose() {
    messagecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: kPrimary,
          elevation: 0.0,
          title: StreamBuilder<
              DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(widget.reuid.trim())
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                  snapshot) {
                GetChatData _chat = GetChatData();

                if(snapshot.connectionState==ConnectionState.waiting){
                   return SizedBox();
                }
                final userData = snapshot.data?.data();
                DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(userData!['Lastseen']));
                final Tag=_chat.formatTimestamp(int.parse(userData!['Lastseen']));
                final Lastseen = DateFormat('h:mm a').format(dateTime);
              return Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[100],
                    backgroundImage: NetworkImage(
                        userData!['Profilepic']),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userData!['Name'],
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: 'MonoRoboto'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text(
                            userData['is_online']=='true'?'online':'$Tag $Lastseen',
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontFamily: 'MonoRoboto'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Chatroom')
                    .doc(widget.uid).collection('Message').orderBy('Date', descending: true).snapshots(),
                builder: (BuildContext context, snapshot) {
                  switch (snapshot.connectionState) {
                  //if data is loading
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const SizedBox();

                  //if some or all data is loaded then show it
                    case ConnectionState.active:
                    case ConnectionState.done:
                    final List<DocumentSnapshot> documents = snapshot.data!.docs;
                    GetChatData _chat=GetChatData();
                     final messageMap=_chat.OrderChatData(documents);
                      if (messageMap.length!=0) {
                        return ListView.builder(
                          reverse: true,
                          itemCount: messageMap.length,
                          itemBuilder: (context, index) {
                            final key = messageMap.keys.elementAt(index);
                            final List<MessageDatamodel>? messages = messageMap[key];
                            final uid=FirebaseAuth.instance.currentUser?.uid;
                            return Column(
                              children: [
                                Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxHeight: 200,
                                          maxWidth: 200,
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(3),
                                            color: Colors.blue[100]),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(3),
                                          child: Text(
                                              key),
                                        ),
                                      ),
                                    )), // Display the key (e.g., today, yesterday, etc.)
                                ListView.builder(
                                  reverse: true,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: messages!.length,
                                  itemBuilder: (context, index) {
                                    final message = messages[index];
                                    // Build your UI for each message
                                    return message.PostedByUserid == uid
                                        ? Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),

                                                child:  Text(message.Date),
                                              ),
                                            ),
                                            Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                maxHeight: 200,
                                                maxWidth: 200,
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(15),
                                                  color: kPrimary),
                                              child: Padding(
                                                padding: const EdgeInsets.all(15),
                                                child: Text(
                                                    message.message),
                                              ),
                                            ),
                                      ),

                                    ),

                                          ],
                                        )
                                        : message.PostedByUserid ==
                                        'System'
                                        ? Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            constraints: BoxConstraints(
                                              maxHeight: 200,
                                              maxWidth: 200,
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(3),
                                                color: Colors.blue[100]),
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(3),
                                              child: Text(
                                                  message.message),
                                            ),
                                          ),
                                        ))
                                        : Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                  constraints: BoxConstraints(
                                                    maxHeight: 200,
                                                    maxWidth: 200,
                                                  ),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(15),
                                                      color: Colors.grey[100]),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.all(15),
                                                    child: Text(message.message),
                                                  ),
                                                ))),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),

                                                child:  Text(message.Date),
                                              ),
                                            ),

                                          ],
                                        );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        return const Center(
                          child: Text('Say Hii! 👋',
                              style: TextStyle(fontSize: 20)),
                        );
                      }
                  }
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: Width * 0.85,
                    child: TextfieldApp(
                      focusnode: _messageFocusNode,
                      Email: messagecontroller,
                      HintText: 'Add Message',
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () async {
                      if (messagecontroller.text.toString().trim() != '') {
                        final uid = FirebaseAuth.instance.currentUser?.uid;
                        String Time =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        MessageDatamodel message = MessageDatamodel(
                            PostedByUserid: uid.toString(),
                            Date: Time,
                            message: messagecontroller.text.toString());
                        AddchatDetails _add = AddchatDetails();
                        await _add.Addmessage(message, widget.uid);
                        messagecontroller.clear();
                      }
                    },
                    child: Icon(
                      Icons.send_rounded,
                      color: kPrimary,
                    )),
              ],
            ),
          ],
        ));
  }
}
