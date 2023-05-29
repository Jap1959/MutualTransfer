// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:connect2prof/CustomWidgets/Colors.dart';
// import 'package:connect2prof/CustomWidgets/Serachbar.dart';
// import 'package:connect2prof/bloc/events.dart';
// import 'package:connect2prof/databaseservices/Streamdata.dart';
// import 'package:connect2prof/pages/ChannelPage.dart';
// import 'package:connect2prof/pages/ChatroomPage.dart';
// import 'package:connect2prof/pages/Homepage.dart';
// import 'package:connect2prof/usermodel/usermodel.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../bloc/ChatPageBLoc.dart';
// import '../bloc/statesofapp.dart';
//
// class ChatInterface extends StatefulWidget {
//   @override
//   State<ChatInterface> createState() => _ChatInterfaceState();
// }
//
// class _ChatInterfaceState extends State<ChatInterface> {
//   TextEditingController search = new TextEditingController();
//   BlocChatPage _blocChatPage = BlocChatPage();
//   @override
//   void initState() {
//     _blocChatPage.add(ChatLoadEvent());
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final Height = MediaQuery.of(context).size.height;
//     final Width = MediaQuery.of(context).size.width;
//     return BlocBuilder<BlocChatPage, AppStates>(
//         bloc: _blocChatPage,
//         builder: (context, state) {
//           if (state is ChatLoadState) {
//             return Center(
//               child: CircularProgressIndicator(
//                 color: kPrimary,
//               ),
//             );
//           }
//           if (state is SearchResultStateforchat) {
//             List<UserDatamodel> results = state.Data;
//             return SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       width: 550,
//                       height: 45,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colors.white,
//                       ),
//                       child: TextFormField(
//                         controller: search,
//                         cursorColor: Colors.black,
//                         enableSuggestions: true,
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.fromLTRB(0.0, 10, 0.0, 10),
//                           hintText: 'Search firends',
//                           hintStyle: TextStyle(color: Colors.white),
//                           prefixIcon: Icon(
//                             Icons.search,
//                             color: Colors.black,
//                           ),
//                           suffixIcon: Icon(
//                             Icons.mic,
//                             color: Colors.black,
//                           ),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide.none,
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide.none,
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           focusColor: Colors.black,
//                         ),
//                         onChanged: (value) {
//                           _blocChatPage.add(SearchEvent(value.toString()));
//                         },
//                       ),
//                     ),
//                   ),
//                   Container(
//                     height: 400,
//                     width: double.infinity,
//                     child: results.length == 0
//                         ? Center(
//                             child: Text(
//                               'No results',
//                               style: TextStyle(
//                                   fontSize: 20,
//                                   color: kPrimary,
//                                   fontFamily: 'MonoRoboto'),
//                             ),
//                           )
//                         : ListView.builder(
//                             itemCount: results.length,
//                             itemBuilder: (BuildContext context, int index) {
//                               return ListTile(
//                                 title: GestureDetector(
//                                   onTap: () {
//                                     Get.to(() => ChatRoomPage(
//                                         Proffesion: results[index].Proffession,
//                                         url: results[index].Profilepic,
//                                         Name: results[index].Name,
//                                         uid: results[index].uid));
//                                   },
//                                   child: Container(
//                                     width: 1000,
//                                     height: 100,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(20),
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(15.0),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.stretch,
//                                         children: [
//                                           Stack(
//                                             children: [
//                                               CircleAvatar(
//                                                 radius: 30,
//                                                 backgroundColor:
//                                                     Colors.grey[100],
//                                                 backgroundImage: NetworkImage(
//                                                     results[index].Profilepic),
//                                               ),
//                                               CircleAvatar(
//                                                 radius: 5,
//                                                 backgroundColor: results[index]
//                                                             .is_online ==
//                                                         'true'
//                                                     ? Colors.lightGreenAccent
//                                                     : Colors.transparent,
//                                                 backgroundImage: NetworkImage(
//                                                     results[index].Profilepic),
//                                               ),
//                                             ],
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.all(15.0),
//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text(
//                                                   results[index].Name,
//                                                   style: TextStyle(
//                                                       fontSize: 20,
//                                                       color: Colors.black,
//                                                       fontFamily: 'MonoRoboto'),
//                                                 ),
//                                                 Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(0.0),
//                                                   child: Text(
//                                                     results[index].Proffession,
//                                                     style: TextStyle(
//                                                         fontSize: 10,
//                                                         color: Colors.black,
//                                                         fontFamily:
//                                                             'MonoRoboto'),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: Width * 0.1,
//                                           ),
//                                           Align(
//                                             alignment: Alignment.topRight,
//                                             child: Text(
//                                               results[index].is_online == 'true'
//                                                   ? 'online'
//                                                   : results[index].LastSeen,
//                                               style: TextStyle(
//                                                   fontSize: 15,
//                                                   color: Colors.grey[400],
//                                                   fontFamily: 'MonoRoboto'),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                   ),
//                 ],
//               ),
//             );
//           }
//           if (state is ChatLoadedState) {
//             List<UserDatamodel> users = state.data;
//             return SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       width: 550,
//                       height: 45,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colors.white,
//                       ),
//                       child: TextFormField(
//                         controller: search,
//                         cursorColor: Colors.black,
//                         enableSuggestions: true,
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.fromLTRB(0.0, 10, 0.0, 10),
//                           hintText: 'Search firends',
//                           hintStyle: TextStyle(color: Colors.grey[500]),
//                           prefixIcon: Icon(
//                             Icons.search,
//                             color: Colors.black,
//                           ),
//                           suffixIcon: Icon(
//                             Icons.mic,
//                             color: Colors.black,
//                           ),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide.none,
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide.none,
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           focusColor: Colors.black,
//                         ),
//                         onChanged: (value) {
//                           _blocChatPage.add(SearchEvent(value.toString()));
//                         },
//                       ),
//                     ),
//                   ),
//                   Container(
//                     height: 400,
//                     width: double.infinity,
//                     child: users.length == 0
//                         ? Center(
//                             child: Text(
//                               'No Chats ',
//                               style: TextStyle(
//                                   fontSize: 20,
//                                   color: kPrimary,
//                                   fontFamily: 'MonoRoboto'),
//                             ),
//                           )
//                         : ListView.builder(
//                             itemCount: users.length,
//                             itemBuilder: (BuildContext context, int index) {
//                               // StreamData streamdata = StreamData();
//                               return StreamBuilder<List<String>>(
//                                   stream: ,
//                                   builder: (context, snapshot) {
//                                     print(users[index].uid);
//                                     if (snapshot.hasError) {
//                                       return Text('Error: ${snapshot.error}');
//                                     }
//
//                                     if (snapshot.connectionState ==
//                                         ConnectionState.waiting) {
//                                       return CircularProgressIndicator();
//                                     }
//                                     List<String> data = snapshot.data!;
//                                     if (snapshot == null) {
//                                       return ListTile(
//                                         title: GestureDetector(
//                                           onTap: () {
//                                             Get.to(() => ChatRoomPage(
//                                                   Proffesion:
//                                                       users[index].Proffession,
//                                                   url: users[index].Profilepic,
//                                                   Name: users[index].Name,
//                                                   uid: users[index].uid,
//                                                 ));
//                                           },
//                                           child: Container(
//                                             width: 1000,
//                                             height: 100,
//                                             decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               borderRadius:
//                                                   BorderRadius.circular(20),
//                                             ),
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(15.0),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.start,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.stretch,
//                                                 children: [
//                                                   Stack(
//                                                     children: [
//                                                       CircleAvatar(
//                                                         radius: 30,
//                                                         backgroundColor:
//                                                             Colors.grey[100],
//                                                         backgroundImage:
//                                                             NetworkImage(users[
//                                                                     index]
//                                                                 .Profilepic),
//                                                       ),
//                                                       Positioned(
//                                                         right: 7,
//                                                         bottom: 10,
//                                                         child: CircleAvatar(
//                                                           radius: 7,
//                                                           backgroundColor: users[
//                                                                           index]
//                                                                       .is_online ==
//                                                                   'true'
//                                                               ? Colors
//                                                                   .lightGreenAccent
//                                                               : Colors
//                                                                   .transparent,
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             15.0),
//                                                     child: Column(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .start,
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         Text(
//                                                           users[index].Name,
//                                                           style: TextStyle(
//                                                               fontSize: 20,
//                                                               color:
//                                                                   Colors.black,
//                                                               fontFamily:
//                                                                   'MonoRoboto'),
//                                                         ),
//                                                         Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .all(0.0),
//                                                           child: Text(
//                                                             users[index]
//                                                                 .Proffession,
//                                                             style: TextStyle(
//                                                                 fontSize: 10,
//                                                                 color: Colors
//                                                                     .black,
//                                                                 fontFamily:
//                                                                     'MonoRoboto'),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   SizedBox(
//                                                     width: Width * 0.1,
//                                                   ),
//                                                   Align(
//                                                     alignment:
//                                                         Alignment.topRight,
//                                                     child: Text(
//                                                       users[index].is_online ==
//                                                               'true'
//                                                           ? 'online'
//                                                           : users[index]
//                                                               .LastSeen,
//                                                       style: TextStyle(
//                                                           fontSize: 10,
//                                                           color:
//                                                               Colors.grey[400],
//                                                           fontFamily:
//                                                               'MonoRoboto'),
//                                                     ),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                     }
//                                     return ListTile(
//                                       title: GestureDetector(
//                                         onTap: () {
//                                           Get.to(() => ChatRoomPage(
//                                                 Proffesion:
//                                                     users[index].Proffession,
//                                                 url: users[index].Profilepic,
//                                                 Name: users[index].Name,
//                                                 uid: users[index].uid,
//                                               ));
//                                         },
//                                         child: Container(
//                                           width: 1000,
//                                           height: 100,
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius:
//                                                 BorderRadius.circular(20),
//                                           ),
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(15.0),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.stretch,
//                                               children: [
//                                                 Stack(
//                                                   children: [
//                                                     CircleAvatar(
//                                                       radius: 30,
//                                                       backgroundColor:
//                                                           Colors.grey[100],
//                                                       backgroundImage:
//                                                           NetworkImage(
//                                                               users[index]
//                                                                   .Profilepic),
//                                                     ),
//                                                     Positioned(
//                                                       right: 7,
//                                                       bottom: 10,
//                                                       child: CircleAvatar(
//                                                         radius: 7,
//                                                         backgroundColor: data[
//                                                                         0] ==
//                                                                     true ||
//                                                                 users[
//                                                                             index]
//                                                                         .is_online ==
//                                                                     'true'
//                                                             ? Colors
//                                                                 .lightGreenAccent
//                                                             : Colors
//                                                                 .transparent,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 Padding(
//                                                   padding: const EdgeInsets.all(
//                                                       15.0),
//                                                   child: Column(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment.start,
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Text(
//                                                         users[index].Name,
//                                                         style: TextStyle(
//                                                             fontSize: 20,
//                                                             color: Colors.black,
//                                                             fontFamily:
//                                                                 'MonoRoboto'),
//                                                       ),
//                                                       Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(0.0),
//                                                         child: Text(
//                                                           users[index]
//                                                               .Proffession,
//                                                           style: TextStyle(
//                                                               fontSize: 10,
//                                                               color:
//                                                                   Colors.black,
//                                                               fontFamily:
//                                                                   'MonoRoboto'),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 SizedBox(
//                                                   width: Width * 0.1,
//                                                 ),
//                                                 Align(
//                                                   alignment: Alignment.topRight,
//                                                   child: Text(
//                                                     data![0] == 'true' ||
//                                                             users[index]
//                                                                     .is_online ==
//                                                                 'true'
//                                                         ? 'online'
//                                                         : data[1] != ''
//                                                             ? data[1]
//                                                             : users[index]
//                                                                 .LastSeen,
//                                                     style: TextStyle(
//                                                         fontSize: 10,
//                                                         color: Colors.grey[400],
//                                                         fontFamily:
//                                                             'MonoRoboto'),
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   });
//                             },
//                           ),
//                   ),
//                 ],
//               ),
//             );
//           }
//           return Container();
//         });
//   }
// }
