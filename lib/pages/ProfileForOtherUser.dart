


import 'package:connect2prof/CustomWidgets/PostdesignProfile.dart';
import 'package:connect2prof/bloc/events.dart';
import 'package:connect2prof/usermodel/usermodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';
import '../CustomWidgets/Colors.dart';
import '../bloc/ProfileLoadBloc.dart';
import '../bloc/statesofapp.dart';
import '../usermodel/PostdataModel.dart';
import 'Homepage.dart';

class ProfileForOther extends StatefulWidget {
   ProfileForOther({required this.uid,required this.Mobile}) ;
  final uid;
  final Mobile;

  @override
  State<ProfileForOther> createState() => _ProfileForOtherState();
}

class _ProfileForOtherState extends State<ProfileForOther> {
  ProfileLoad _profile = ProfileLoad();

  @override
  void initState() {
    super.initState();
    _profile.add(ProfilePageEvent(widget.uid.toString()));
    _profile.stream.listen((state) {
      if(state is AddedState){
        WidgetsBinding.instance?.addPostFrameCallback((_) {

          Get.to(()=>Homepage(noticount: state.notiount, index:1,));
          // Use the context here
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final Height = MediaQuery
        .of(context)
        .size
        .height;
    final Width = MediaQuery
        .of(context)
        .size
        .width;
    return BlocBuilder<ProfileLoad, AppStates>(
      bloc: _profile,
      builder: (context, state) {
        if (state is Pageloading) {
          return Container(
            height: Height,
            width: Width,
            color: Colors.grey[100],
            child: Center(
              child: CircularProgressIndicator(
                color: kPrimary,
              ),
            ),
          );
        }
        if (state is ButtonPressedState){
          Get.dialog(
            Center(
              child: SpinKitChasingDots(
                color: kPrimary,
              ),
            ),
            barrierDismissible: false,
          );
        }
        if (state is ProfilePageLoadedstate) {
          List<PostdataModel> Users = state.Data;
          UserDatamodel userdetails=state.user;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              leading: GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back_ios_new,color: Colors.black,)),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Profile',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontFamily: 'MonoRoboto'),
                  ),
                  SizedBox(
                    width: Width * 0.50,
                  ),
                ],
              ),
            ),
              body: Padding(
              padding: const EdgeInsets.all(8.0),
              child:  Container(
                height: Height,
                width: double.infinity,
                color: Colors.grey[100],
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: Users.length+1,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(
                          0.0, 15, 0.0, 0.0),
                      child: ListTile(
                        title: GestureDetector(
                          onTap: () {},
                          child: index==0?Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundImage: NetworkImage(
                                        userdetails.Profilepic),
                                  ),
                                  SizedBox(width: Width * 0.01,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(userdetails.Name, style: TextStyle(
                                        fontFamily: 'RobotoMono',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      Row(
                                        children: [
                                          Container(
                                            height: Height * 0.06,
                                            width: Width * 0.15,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              color: kPrimary,
                                            ),
                                            child: Column(
                                              children: [
                                                Center(
                                                  child: GestureDetector(
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
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(top: 10),
                                                      child: const Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [

                                                          Icon(Icons.phone,color: Colors.white,),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: Width*0.01,),
                                          Container(
                                            height: Height * 0.06,
                                            width: Width * 0.15,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              color: kPrimary,
                                            ),
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                   _profile.add(MessageEvent(widget.uid));
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(top: 10),
                                                    child: const Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [

                                                        Icon(Icons.message,color: Colors.white,),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text(userdetails.Proffession, style: TextStyle(
                                        fontFamily: 'RobotoMono',
                                        fontSize: 20,
                                      ),),
                                      Text('Proffession', style: TextStyle(
                                        fontFamily: 'RobotoMono',
                                        fontSize: 15,
                                        color: Colors.grey[700],
                                      ),),
                                    ],
                                  ),
                                  Container(
                                    color: Colors.grey,
                                    height: Height * 0.055,
                                    width: 1,
                                  ),
                                  Column(
                                    children: [
                                      Text(Users.length.toString(), style: TextStyle(
                                        fontFamily: 'RobotoMono',
                                        fontSize: 20,
                                      ),),
                                      Text('Posts', style: TextStyle(
                                        fontFamily: 'RobotoMono',
                                        fontSize: 15,
                                        color: Colors.grey[700],
                                      ),),
                                    ],
                                  ),
                                  Container(
                                    color: Colors.grey,
                                    height: Height * 0.055,
                                    width: 1,
                                  ),
                                  Column(
                                    children: [
                                      Text(Users.length==0?'Not Updated yet':Users[0].CurrentPlace, style: TextStyle(
                                        fontFamily: 'RobotoMono',
                                        fontSize: 20,
                                      ),),
                                      Text('CurrentPlace', style: TextStyle(
                                        fontFamily: 'RobotoMono',
                                        fontSize: 15,
                                        color: Colors.grey[700],
                                      ),),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ):Users.length==0?Center(child: Text(
                              'No Post Yet Add First Post', style: TextStyle(
                              fontFamily: 'MonoRoboto',
                              fontSize: 20,
                              color: kPrimary)),):Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PostProfileDesign(
                              CurrentPlace: Users[index-1].CurrentPlace,
                              DestinationPlace: Users[index-1]
                                  .DestinationPlace,
                              decription: Users[index-1].description,
                              Mobile: Users[index-1].MobileNo,
                              url: Users[index-1].Profilepic,
                              Name: Users[index-1].Name,
                              Proffesion: Users[index-1].Proffession,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
