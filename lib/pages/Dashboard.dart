
import 'package:connect2prof/CustomWidgets/PostDesign.dart';
import 'package:connect2prof/CustomWidgets/Serachbar.dart';
import 'package:connect2prof/usermodel/PostdataModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' ;
import '../CustomWidgets/Colors.dart';
import '../bloc/appbloc.dart';
import '../bloc/events.dart';
import '../bloc/statesofapp.dart';
import 'Homepage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with AutomaticKeepAliveClientMixin<Dashboard> {
  BlocHompage _blochomepage = BlocHompage();
  bool readMore = false;
  final PageStorageBucket bucket = PageStorageBucket(); // Add this line

  @override
  void initState() {
    super.initState();
    _blochomepage.add(HomePageDataEvent());
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
              color: Colors.black,
            ),
          );
        }
        if (state is PageLoadedstate) {
          List<PostdataModel> Users = state.Data;
          return PageStorage( // Wrap with PageStorage
            bucket: bucket,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SearchBarApp(
                      Hintext: 'Search place,Profession....',
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: Height*0.7,
                    width: double.infinity,
                    child:Users.length==0?Center(child: Text('No Post Yet Add First Post',style: TextStyle(fontFamily: 'MonoRoboto',fontSize: 20,color: kPrimary)),) :ListView.builder(
                      itemCount: Users.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(
                            "--------------------------------------->${Users[index].DestinationPlace}");
                        return ListTile(
                          title: GestureDetector(
                            onTap: () {},
                            child: PostDesign(
                              CurrentPlace: Users[index].CurrentPlace,
                              DestinationPlace: Users[index].DestinationPlace,
                              decription: Users[index].description,
                              Mobile: Users[index].MobileNo, url: Users[index].Profilepic, Name: Users[index].Name,
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
        return Homepage();
      },
    );
  }
}
