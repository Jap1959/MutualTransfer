
import 'package:connect2prof/CustomWidgets/PostDesign.dart';
import 'package:connect2prof/CustomWidgets/Serachbar.dart';
import 'package:connect2prof/databaseservices/Adddata.dart';
import 'package:connect2prof/pages/ProfileForOtherUser.dart';
import 'package:connect2prof/pages/ProfilePage.dart';
import 'package:connect2prof/pages/SinglePostPage.dart';
import 'package:connect2prof/pages/chatInterface.dart';
import 'package:connect2prof/usermodel/PostUploadDatamodel.dart';
import 'package:connect2prof/usermodel/PostdataModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' ;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../CustomWidgets/Colors.dart';
import '../bloc/HomepageBloc.dart';
import '../bloc/ChatPageBLoc.dart';
import '../bloc/events.dart';
import '../bloc/statesofapp.dart';
import 'Homepage.dart';
bool isFirstTime = true;
List<PostdataModel> Users=[];
class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with AutomaticKeepAliveClientMixin<Dashboard> {
  TextEditingController Search=new TextEditingController();
  final PageStorageBucket bucket = PageStorageBucket(); // Add this line


 BlocHompage _blochomepage= BlocHompage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _blochomepage.add(HomePageDataEvent());
    _blochomepage.stream.listen((state) {
      if(state is AddedState){
        WidgetsBinding.instance?.addPostFrameCallback((_) {

          Get.offAll(()=>Homepage(noticount: state.notiount, index:1,));
          // Use the context here
        });
      }
    });
  }
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;

    return BlocBuilder<BlocHompage, AppStates>(
      bloc: _blochomepage,
      builder: (context, state) {
        if (state is Pageloading) {
          return Center(
            child: CircularProgressIndicator(
              color: kPrimary,
            ),
          );
        }
        else if(state is SearchingState){
          return Center(
            child: CircularProgressIndicator(
              color: kPrimary,
            ),
          );
        }
        else if(state is SearchResultState){
           List<PostdataModel> Searchresults = state.Data;
          return PageStorage( // Wrap with PageStorage
            bucket: bucket,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 550,
                      height:45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: Search,
                        cursorColor: Colors.black,
                        enableSuggestions: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(0.0, 10, 0.0, 10),
                          hintText: 'Search Place,Name,Proffession',
                          hintStyle: TextStyle(color:Colors.grey[500]),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          suffixIcon: Icon(Icons.mic,color: Colors.black,),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusColor: Colors.black,
                        ),
                        onChanged: (value){
                            _blochomepage.add(
                                SearchEvent(value.toString()));
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: Height*0.7,
                    width: double.infinity,
                    child:state is ButtonPressedState?Center(child:SpinKitChasingDots(
                      color: kPrimary,
                    ),):Searchresults.length==0?Center(child: Text('No Results found',style: TextStyle(fontFamily: 'MonoRoboto',fontSize: 20,color: kPrimary)),) :ListView.builder(
                      itemCount: Searchresults.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: GestureDetector(
                            onTap: () {
                              Get.to(()=>SinglePostPage(Name: Users[index].Name, Proffesion: Users[index].Proffession, Profilepic: Users[index].Profilepic, CurrentPlace: Users[index].CurrentPlace, Mobile: Users[index].MobileNo, DestinationPlace: Users[index].DestinationPlace, decription: Users[index].description));
                            },
                            child: PostDesign(
                              CurrentPlace: Searchresults[index].CurrentPlace,
                              DestinationPlace: Searchresults[index].DestinationPlace,
                              decription: Searchresults[index].description,
                              Mobile: Searchresults[index].MobileNo, url: Searchresults[index].Profilepic, Name: Searchresults[index].Name, Proffesion: Searchresults[index].Proffession, onTap: (){
                              _blochomepage.add(MessageEvent(Users[index].PostedByUserid));
                            }, ProfileTap: () {
                                Get.to(()=>ProfileForOther(uid: Searchresults[index].PostedByUserid,Mobile:Users[index].MobileNo));
                            },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        else if (state is PageLoadedstate  ) {
          List<PostdataModel> Users = state.Data;
             print(Users.length);
          return RefreshIndicator(
            onRefresh:()async {
              _blochomepage.add(HomePageDataEvent());
            },
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 550,
                      height:45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: Search,
                        cursorColor: Colors.black,
                        enableSuggestions: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(0.0, 10, 0.0, 10),
                          hintText: 'Search Place,Name,Proffession',
                          hintStyle: TextStyle(color:Colors.grey[500]),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          suffixIcon: Icon(Icons.mic,color: Colors.black,),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusColor: Colors.black,
                        ),
                        onChanged: (value){
                        _blochomepage.add(SearchEvent(value.toString()));
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: Height*0.7,
                    width: double.infinity,
                    child:state is ButtonPressedState?Center(child:SpinKitChasingDots(
                      color: kPrimary,
                    ),):Users.length==0?Center(child: Text('No Post Yet Add First Post',style: TextStyle(fontFamily: 'MonoRoboto',fontSize: 20,color: kPrimary)),) :RefreshIndicator(
                      onRefresh: () async{
                       _blochomepage.add(HomePageDataEvent());
                      },
                      child: ListView.builder(
                        itemCount: Users.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: GestureDetector(
                              onTap: () {
                                Get.to(()=>SinglePostPage(Name: Users[index].Name, Proffesion: Users[index].Proffession, Profilepic: Users[index].Profilepic, CurrentPlace: Users[index].CurrentPlace, Mobile: Users[index].MobileNo, DestinationPlace: Users[index].DestinationPlace, decription: Users[index].description));
                              },
                              child: PostDesign(
                                CurrentPlace: Users[index].CurrentPlace,
                                DestinationPlace: Users[index].DestinationPlace,
                                decription: Users[index].description,
                                Mobile: Users[index].MobileNo, url: Users[index].Profilepic, Name: Users[index].Name, Proffesion:Users[index].Proffession, onTap:(){
                              _blochomepage.add(MessageEvent(Users[index].PostedByUserid));
                              }, ProfileTap: () {
                                  final uid=FirebaseAuth.instance.currentUser?.uid;
                                  if(uid==Users[index].PostedByUserid){
                                    Get.to(()=>Homepage(noticount: 0, index: 2));
                                  }
                                  else
                                  Get.to(()=>ProfileForOther(uid:Users[index].PostedByUserid,Mobile:Users[index].MobileNo));
                              },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
