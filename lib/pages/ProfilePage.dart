
import 'package:connect2prof/CustomWidgets/PostdesignProfile.dart';
import 'package:connect2prof/bloc/events.dart';
import 'package:connect2prof/pages/ProfileEditPage.dart';
import 'package:connect2prof/usermodel/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../CustomWidgets/Colors.dart';
import '../bloc/ProfileLoadBloc.dart';
import '../bloc/statesofapp.dart';
import '../databaseservices/GetData.dart';
import '../usermodel/PostdataModel.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileLoad _profile = ProfileLoad();

  @override
  void initState() {
    super.initState();
    final uid=FirebaseAuth.instance.currentUser?.uid;
    _profile.add(ProfilePageEvent(uid.toString()));
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
          return Center(
            child: CircularProgressIndicator(
              color: kPrimary,
            ),
          );
        }
        if (state is ProfilePageLoadedstate) {
          List<PostdataModel> Users = state.Data;
            UserDatamodel userdetails=state.user;
          return Padding(
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
                                    GestureDetector(
                                      onTap: () async {
                                        GetData _getdata = GetData();
                                        final uid=FirebaseAuth.instance.currentUser?.uid;
                                        final user = await _getdata.Currentuser(uid.toString());
                                        print(user);
                                        Get.to(() =>
                                            ProfileEditPage(Name: user.Name,
                                                Mobile: user.Mobile_no,
                                                url: user.Profilepic,
                                                Email: user.Email,
                                                City: user.currentplace));
                                      },
                                      child: Container(
                                        height: Height * 0.04,
                                        width: Width * 0.15,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: kPrimary,
                                        ),
                                        child: Center(
                                          child: Text('Edit', style: TextStyle(
                                            fontFamily: 'RobotoMono',
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),),
                                        ),
                                      ),
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
                            url: userdetails.Profilepic,
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
          );
        }
        return Container();
      },
    );
  }
}
