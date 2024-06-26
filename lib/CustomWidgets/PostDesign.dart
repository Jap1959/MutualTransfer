


import 'package:connect2prof/CustomWidgets/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PostDesign extends StatefulWidget {
  PostDesign({required this.CurrentPlace,required this.DestinationPlace,required this.decription,required this.Mobile, required this.url, required this.Name, required this.Proffesion, required this.onTap, required this.ProfileTap});
  final String CurrentPlace;
  final String DestinationPlace;
  final String url;
  final String decription;
  final String Mobile;
  final String Name;
  final String Proffesion;
  final VoidCallback onTap;
  final VoidCallback ProfileTap;

  @override
  State<PostDesign> createState() => _PostDesignState();
}
class _PostDesignState extends State<PostDesign> {
  bool readMore = false;
  @override
  Widget build(BuildContext context) {
    final Width=MediaQuery.of(context).size.width;
    final Height=MediaQuery.of(context).size.height;
    return Container(
      width: Width,
      height: Height*0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: widget.ProfileTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.url),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 8, 0.0, 0.0),
                      child: Text(widget.Name,style: TextStyle(fontFamily: 'MonoRoboto',fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                    ),
                    SizedBox(width: Width*0.2,),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Column(
                        children: [
                          Text(widget.CurrentPlace,
                              maxLines: 1,
                              style: TextStyle(fontFamily: 'MonoRoboto',fontSize: 13,color: Colors.black,)),
                          Text('CurrentPlace',style: TextStyle(fontFamily: 'MonoRoboto',fontSize: 8,color: kPrimary)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: Height*0.01,),
              Container(
                height: 1,
                width: Width,
                color: Colors.grey[300],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

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
                        SizedBox(width: Width*0.05,),
                        Text(widget.Proffesion,style: TextStyle(fontFamily: 'MonoRoboto',fontSize: 15,color: Colors.black)),
                      ],
                    ),
                    SizedBox(height: Height*0.01,),

                    Expanded(
                      child: Text(
                        widget.decription,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),

              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                          Icon(Icons.phone_outlined,color: kPrimary,),
                          SizedBox(width: Width*0.01,),
                          Text('Call',style: TextStyle(fontFamily: 'MonoRoboto',fontSize: 20,color: kPrimary)),
                        ],
                      ),
                    ),
                    SizedBox(width: Width*0.1,),
                    GestureDetector(
                      onTap:widget.onTap,
                      child: Row(
                        children: [
                          Icon(Icons.message_outlined,color: kPrimary,),
                          SizedBox(width: Width*0.01,),
                          Text('Message',style: TextStyle(fontFamily: 'MonoRoboto',fontSize: 20,color: kPrimary)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}
