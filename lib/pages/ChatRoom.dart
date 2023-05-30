import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect2prof/CustomWidgets/Colors.dart';
import 'package:connect2prof/databaseservices/GetChatData.dart';
import 'package:connect2prof/pages/chatInterface.dart';
import 'package:connect2prof/usermodel/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../authentication/auth.dart';
import 'ChatroomPage.dart';
String _searchQuery = '';
class Chatroom extends StatefulWidget {
  const Chatroom({Key? key}) : super(key: key);

  @override
  State<Chatroom> createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  final TextEditingController _searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;
    final Height = MediaQuery.of(context).size.height;
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 550,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: TextFormField(
                controller: _searchController,
                cursorColor: Colors.black,
                enableSuggestions: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(0.0, 10, 0.0, 10),
                  hintText: 'Search firends',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  suffixIcon: Icon(
                    Icons.mic,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusColor: Colors.black,
                ),
                onChanged: (value) {
                   setState(() {
                     _searchQuery=value;
                   });
                  print(value);
                },
              ),
            ),
          ),
           SizedBox(
            height: Height * 0.69,
            width: Width,
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(uid)
                  .collection('ChatRoom').snapshots(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasError) {
                  // Handle error state
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Handle waiting/loading state
                  return Center(
                    child: CircularProgressIndicator(
                      color: kPrimary,
                    ),
                  );
                }
                 if(snapshot.hasData==false){
                   return Center(
                     child: CircularProgressIndicator(
                       color: kPrimary,
                     ),
                   );
                 }

                final userListmain = snapshot.data!;


                GetChatData _chat=GetChatData();
                final List<String> userList=_chat.filterUsers(userListmain, _searchQuery);
                return userList.length==0?Center(child: Text('No Results'),):ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(userList[index]);
                    List<String> Parts = userList[index].split('_');
                    String userid;
                    if (Parts[0] != uid) {
                      userid = Parts[0];
                    } else {
                      userid = Parts[1];
                    }
                    return StreamBuilder<
                        DocumentSnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .doc(userid)
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.hasError) {
                          // Handle error state
                          return Text('Error: ${snapshot.error}');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {

                        }
                         if(snapshot.hasData){
                        final userData = snapshot.data!.data();
                          GetChatData _chat = GetChatData();
                            DateTime dateTime = DateTime
                                .fromMillisecondsSinceEpoch(
                                int.parse(userData!['Lastseen']));
                            final Tag = _chat.formatTimestamp(
                                int.parse(userData!['Lastseen']));
                            final Lastseen = DateFormat('h:mm a').format(
                                dateTime);
                          return ListTile(
                            title: GestureDetector(
                              onTap: () async {
                                GetChatData _chat = GetChatData();
                                final Chatid = await _chat.GetChatid(
                                    userData!['uid'] ?? '');
                                Get.to(() =>
                                    ChatRoomPage(
                                      Proffesion: userData!['Proffession'] ??
                                          '',
                                      url: userData!['Profilepic'] ?? '',
                                      Name: userData!['Name'] ?? '',
                                      uid: Chatid,
                                      reuid: userData!['uid'] ?? '',
                                    ));
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                    children: [
                                      Stack(
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Colors.grey[100],
                                            backgroundImage: NetworkImage(
                                                userData!['Profilepic']),
                                          ),
                                          Positioned(
                                            right: 7,
                                            bottom: 10,
                                            child: CircleAvatar(
                                              radius: 5,
                                              backgroundColor:
                                              userData!['is_online'] == 'true'
                                                  ? Colors.green[600]
                                                  : Colors.transparent,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              userData!['Name'],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontFamily: 'MonoRoboto'),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                  0.0),
                                              child: Text(
                                                userData!['Proffession'],
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontFamily: 'MonoRoboto'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: Width * 0.1,
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          userData!['is_online'] == 'true'
                                              ? 'online'
                                              : '$Tag $Lastseen',
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey[400],
                                              fontFamily: 'MonoRoboto'),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        return SizedBox();
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
