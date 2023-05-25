


import 'package:connect2prof/CustomWidgets/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PostProfileDesign extends StatefulWidget {
  PostProfileDesign({required this.CurrentPlace,required this.DestinationPlace,required this.decription,required this.Mobile, required this.url, required this.Name, required this.Proffesion});
  final String CurrentPlace;
  final String DestinationPlace;
  final String url;
  final String decription;
  final String Mobile;
  final String Name;
  final String Proffesion;

  @override
  State<PostProfileDesign> createState() => _PostProfileDesignState();
}
class _PostProfileDesignState extends State<PostProfileDesign> {
  bool readMore = false;
  @override
  Widget build(BuildContext context) {
    final Width=MediaQuery.of(context).size.width;
    final Height=MediaQuery.of(context).size.height;
    return Container(
      width: Width,
      height: Height*0.35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.url),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0.0, 0.0),
                    child: Text(widget.Name,style: TextStyle(fontFamily: 'MonoRoboto',fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                  ),
                  SizedBox(width: Width*0.1,),
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
              SizedBox(height: Height*0.01,),
              Container(
                height: 1,
                width: Width,
                color: Colors.grey[300],
              ),
              Card(
                shadowColor: Colors.transparent,
                child: SingleChildScrollView(
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
                      Text(
                        widget.decription,
                        textAlign: TextAlign.center,
                        maxLines: readMore ? 100 : 8,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

              ),
            ],
          )
      ),
    );
  }
}
