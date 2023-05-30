// import 'package:connect2prof/databaseservices/GetChatData.dart';
// import 'package:connect2prof/usermodel/MessageDatamodel.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../CustomWidgets/Colors.dart';
// import '../databaseservices/AddchatRoomDetails.dart';
//
// class ChatScreen extends StatefulWidget {
//   final uid,Proffesion,Name,url;
//
//   const ChatScreen({super.key, required this.uid,required this.Proffesion,required this.Name,required this.url});
//
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   //for storing all messages
//   List<MessageDatamodel> _list = [];
//
//   //for handling message text changes
//   final _textController = TextEditingController();
//   GetChatData _chat=GetChatData();
//
//   //showEmoji -- for storing value of showing or hiding emoji
//   //isUploading -- for checking if image is uploading or not?
//   bool _showEmoji = false, _isUploading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final Height=MediaQuery.of(context).size.height;
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: SafeArea(
//         child: WillPopScope(
//           //if emojis are shown & back button is pressed then hide emojis
//           //or else simple close current screen on back button click
//           onWillPop: () {
//             if (_showEmoji) {
//               setState(() => _showEmoji = !_showEmoji);
//               return Future.value(false);
//             } else {
//               return Future.value(true);
//             }
//           },
//           child: Scaffold(
//             //app bar
//             appBar: AppBar(
//               backgroundColor: kPrimary,
//               elevation: 0.0,
//               title: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 20,
//                     backgroundColor: Colors.grey[100],
//                     backgroundImage: NetworkImage(widget.url),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           widget.Name,
//                           style: TextStyle(
//                               fontSize: 20,
//                               color: Colors.white,
//                               fontFamily: 'MonoRoboto'),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(0.0),
//                           child: Text(
//                             widget.Proffesion,
//                             style: TextStyle(
//                                 fontSize: 10,
//                                 color: Colors.white,
//                                 fontFamily: 'MonoRoboto'),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             backgroundColor: Colors.white,
//
//             //body
//             body: Column(
//               children: [
//                 Expanded(
//                   child: StreamBuilder(
//                     stream: _chat.GetChats(widget.uid),
//                     builder: (context, snapshot) {
//                       switch (snapshot.connectionState) {
//                       //if data is loading
//                         case ConnectionState.waiting:
//                         case ConnectionState.none:
//                           return const SizedBox();
//
//                       //if some or all data is loaded then show it
//                         case ConnectionState.active:
//                         case ConnectionState.done:
//                           _list = snapshot.data!;
//                           if (_list.isNotEmpty) {
//                             return ListView.builder(
//                                 reverse: true,
//                                 itemCount: _list.length,
//                                 padding: EdgeInsets.only(top: Height * .01),
//                                 physics: const BouncingScrollPhysics(),
//                                 itemBuilder: (context, index) {
//                                   final uid=FirebaseAuth.instance.currentUser?.uid;
//                                   return _list[index].PostedByUserid == uid
//                                       ? Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Container(
//                                         constraints: BoxConstraints(
//                                           maxHeight: 200,
//                                           maxWidth: 200,
//                                         ),
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                             BorderRadius.circular(15),
//                                             color: Colors.grey[200]),
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(15),
//                                           child: Text(
//                                               _list[index].message),
//                                         ),
//                                       ),
//                                     ),
//                                   )
//                                       : _list[index].PostedByUserid ==
//                                       'System'
//                                       ? Align(
//                                       alignment: Alignment.center,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Container(
//                                           constraints: BoxConstraints(
//                                             maxHeight: 200,
//                                             maxWidth: 200,
//                                           ),
//                                           decoration: BoxDecoration(
//                                               borderRadius:
//                                               BorderRadius.circular(3),
//                                               color: Colors.blue[100]),
//                                           child: Padding(
//                                             padding:
//                                             const EdgeInsets.all(3),
//                                             child: Text(
//                                                 _list[index].message),
//                                           ),
//                                         ),
//                                       ))
//                                       : Align(
//                                       alignment: Alignment.centerRight,
//                                       child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Container(
//                                             constraints: BoxConstraints(
//                                               maxHeight: 200,
//                                               maxWidth: 200,
//                                             ),
//                                             decoration: BoxDecoration(
//                                                 borderRadius:
//                                                 BorderRadius.circular(15),
//                                                 color: kPrimary),
//                                             child: Padding(
//                                               padding:
//                                               const EdgeInsets.all(15),
//                                               child: Text(_list[index].message),
//                                             ),
//                                           )));
//                                 });
//                           } else {
//                             return const Center(
//                               child: Text('Say Hii! 👋',
//                                   style: TextStyle(fontSize: 20)),
//                             );
//                           }
//                       }
//                     },
//                   ),
//                 ),
//
//                 //progress indicator for showing uploading
//                 if (_isUploading)
//                   const Align(
//                       alignment: Alignment.centerRight,
//                       child: Padding(
//                           padding:
//                           EdgeInsets.symmetric(vertical: 8, horizontal: 20),
//                           child: CircularProgressIndicator(strokeWidth: 2))),
//
//                 //chat input filed
//                 _chatInput(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _chatInput() {
//     return Row(
//       children: [
//         //input field & buttons
//         Expanded(
//           child: Card(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15)),
//             child: Row(
//               children: [
//                 Expanded(
//                     child: TextField(
//                       controller: _textController,
//                       keyboardType: TextInputType.multiline,
//                       maxLines: null,
//                       onTap: () {
//                         if (_showEmoji) setState(() => _showEmoji = !_showEmoji);
//                       },
//                       decoration: const InputDecoration(
//                           hintText: 'Type Something...',
//                           hintStyle: TextStyle(color: Colors.blueAccent),
//                           border: InputBorder.none),
//                     )),
//               ],
//             ),
//           ),
//         ),
//
//         //send message button
//         MaterialButton(
//           onPressed: () async {
//             if (_textController.text.isNotEmpty) {
//               final uid = FirebaseAuth.instance.currentUser?.uid;
//               String Time =
//               DateTime.now().millisecondsSinceEpoch.toString();
//               MessageDatamodel message = MessageDatamodel(
//                   PostedByUserid: uid.toString(),
//                   Date: Time,
//                   message: _textController.text.toString());
//               AddchatDetails _add = AddchatDetails();
//               await _add.Addmessage(message, widget.uid);
//               _textController.text = '';
//             }
//           },
//           minWidth: 0,
//           padding:
//           const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
//           shape: const CircleBorder(),
//           color: Colors.tealAccent,
//           child: const Icon(Icons.send, color: Colors.white, size: 28),
//         )
//       ],
//     );
//   }
// }
