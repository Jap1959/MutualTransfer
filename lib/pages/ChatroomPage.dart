import 'dart:async';

import 'package:connect2prof/CustomWidgets/Textfield.dart';
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

import '../CustomWidgets/Colors.dart';
import '../bloc/statesofapp.dart';

class ChatRoomPage extends StatefulWidget {
  ChatRoomPage(
      {required this.Proffesion,
      required this.url,
      required this.Name,
      required this.uid});
  String Name;
  String Proffesion;
  String url;
  String uid;

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  late TextEditingController messagecontroller;
  late FocusNode _messageFocusNode;

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
          title: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[100],
                backgroundImage: NetworkImage(widget.url),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.Name,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: 'MonoRoboto'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Text(
                        widget.Proffesion,
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
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<MessageDatamodel>>(
                  stream: _chat.GetChats(widget.uid).asStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData == false) {
                      return Center(
                        child: Text('Say Hii'),
                      );
                    }
                    List<MessageDatamodel> MessageList = snapshot.data!;
                    print(MessageList.length);
                    return Container(
                        height: Height * .4,
                        width: Width,
                        child: ListView.builder(
                            itemCount: MessageList.length,
                            itemBuilder: (context, int index) {
                              final uid =
                                  FirebaseAuth.instance.currentUser?.uid;
                              return MessageList[index].PostedByUserid == uid
                                  ? Align(
                                      alignment: Alignment.centerLeft,
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
                                              color: Colors.grey[200]),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Text(
                                                MessageList[index].message),
                                          ),
                                        ),
                                      ),
                                    )
                                  : MessageList[index].PostedByUserid ==
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
                                                    MessageList[index].message),
                                              ),
                                            ),
                                          ))
                                      : Align(
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
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Text(
                                                    MessageList[index].message),
                                              ),
                                            ),
                                          ));
                            }));
                  }),
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
                        _messageFocusNode.unfocus();
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
