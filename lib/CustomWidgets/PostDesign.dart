


import 'package:connect2prof/CustomWidgets/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PostDesign extends StatefulWidget {
  PostDesign({required this.CurrentPlace,required this.DestinationPlace,required this.decription,required this.Mobile, required this.url, required this.Name});
  final String CurrentPlace;
  final String DestinationPlace;
  final String url;
  final String decription;
  final String Mobile;
  final String Name;

  @override
  State<PostDesign> createState() => _PostDesignState();
}
// https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg
class _PostDesignState extends State<PostDesign> {
  bool readMore = false;
  @override
  Widget build(BuildContext context) {
    final Width=MediaQuery.of(context).size.width;
    final Height=MediaQuery.of(context).size.height;
    return Container(
      width: 1200,
      height: 325,
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
                    padding: const EdgeInsets.fromLTRB(10, 8, 0.0, 0.0),
                    child: Text(widget.Name,style: TextStyle(fontFamily: 'MonoRoboto',fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                  ),
                  SizedBox(width: Width*0.4,),
                  Column(
                    children: [
                      Text(widget.CurrentPlace,
                          maxLines: 1,
                          style: TextStyle(fontFamily: 'MonoRoboto',fontSize: 12,color: Colors.black,)),
                      Text('CurrentPlace',style: TextStyle(fontFamily: 'MonoRoboto',fontSize: 8,color: kPrimary)),
                    ],
                  )
                ],
              ),
              SizedBox(height: Height*0.01,),
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
                         Text(widget.DestinationPlace,style: TextStyle(fontFamily: 'MonoRoboto',fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
                       ],
                     ),
                      SizedBox(height: Height*0.01,),
                      Text(
                        widget.decription,
                        textAlign: TextAlign.center,
                        maxLines: readMore ? 100 : 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
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
                        print('Pressesd-------------------->');
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
                    Icon(Icons.message_outlined,color: kPrimary,),
                    SizedBox(width: Width*0.01,),
                    Text('Message',style: TextStyle(fontFamily: 'MonoRoboto',fontSize: 20,color: kPrimary)),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}
