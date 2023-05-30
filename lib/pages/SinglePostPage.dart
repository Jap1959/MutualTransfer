

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../CustomWidgets/Colors.dart';

class SinglePostPage extends StatefulWidget {
  SinglePostPage({required this.Name,required this.Proffesion,required this.Profilepic,required this.CurrentPlace,required this.Mobile,required this.DestinationPlace,required this.decription});
  final Name;
  final decription;
  final Profilepic;
  final DestinationPlace;
  final Mobile;
  final Proffesion;
  final CurrentPlace;

  @override
  State<SinglePostPage> createState() => _SinglePostPageState();
}

class _SinglePostPageState extends State<SinglePostPage> {
  @override
  Widget build(BuildContext context) {
    final Height=MediaQuery.of(context).size.height;
    final Width=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_new,color: Colors.black,
          ),
        ),
        title:Text('Post',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.black))
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: Height,
          width: Width,
          child: SingleChildScrollView(
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       CircleAvatar(
                         radius: 80,
                         backgroundColor: Colors.grey[100],
                         backgroundImage: NetworkImage(
                             widget.Profilepic),
                       ),
                       Column(
                         children: [
                           Text(
                             widget.Name,
                             style: TextStyle(
                                 fontSize: 25,
                                 color: Colors.black,
                                 fontFamily: 'MonoRoboto'),
                           ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Container(
                               height: Height*0.08,
                               width: Width*0.2,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(15),
                                 color: kPrimary,
                               ),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 children: [
                                   GestureDetector(
                                     onTap: () async {
                                       final Uri launchUri = Uri(
                                         scheme: 'tel',
                                         path: widget.Mobile,
                                       );

                                       try{
                                         await launchUrl(launchUri);
                                       }
                                       catch(e){
                                         print(e.toString());
                                       }
                                     },
                                     child: Row(
                                       children: [
                                         Icon(Icons.phone_outlined,color: Colors.white,),
                                         SizedBox(width: Width*0.01,),
                                         Text('Call',style: TextStyle(fontFamily: 'MonoRoboto',fontSize: 20,color: Colors.white)),
                                       ],
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           ),
                         ],
                       ),
                     ],
                   ),

                   Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Padding(
                         padding: const EdgeInsets.only(top: 12),
                         child: Row(
                           children: [
                             Text('CurrentPlace',style: TextStyle(fontFamily: 'MonoRoboto',fontSize: 15,color: kPrimary)),
                             SizedBox(width: Width*0.05,),
                             Text(widget.CurrentPlace,
                                 maxLines: 1,
                                 style: TextStyle(fontFamily: 'MonoRoboto',fontSize: 15,color: Colors.black,)),

                           ],
                         ),
                       ),
                       Row(
                         children: [
                           Text('RequiredPlace',style: TextStyle(fontFamily: 'MonoRoboto',fontSize: 15,color: kPrimary)),
                           SizedBox(width: Width*0.05,),
                           Text(widget.DestinationPlace,style: TextStyle(fontFamily: 'MonoRoboto',fontSize: 15,color: Colors.black)),
                         ],
                       ),
                       Row(
                         children: [
                           Text('Proffession',style: TextStyle(fontFamily: 'MonoRoboto',fontSize: 15,color: kPrimary)),
                           SizedBox(width: Width*0.08,),
                           Text(widget.Proffesion,style: TextStyle(fontFamily: 'MonoRoboto',fontSize: 15,color: Colors.black)),
                         ],
                       ),
                       SizedBox(height: Height*0.01,),

                       Text(
                         widget.decription,
                         textAlign: TextAlign.center,
                       ),
                     ],
                   ),
                 ],
               ),
             ),
          ),
        ),
      ),
    );
  }
}
