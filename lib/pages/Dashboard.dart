
import 'package:connect2prof/usermodel/usermodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

import '../authentication/auth.dart';
import '../bloc/appbloc.dart';
import '../bloc/events.dart';
import '../bloc/statesofapp.dart';
import 'Homepage.dart';
import 'Loginpage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  BlocHompage _blochomepage=BlocHompage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _blochomepage.add(HomePageDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<BlocHompage,AppStates>(
    bloc: _blochomepage,
        builder: (context,state){
      if(state is Pageloading){
          return Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
      }
      if(state is PageLoadedstate){
        List<UserDatamodel> Users=state.Data;
        return  SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Find Your Pairs!!!',style: TextStyle(fontSize: 20, color: Colors.black, fontWeight:FontWeight.bold,fontFamily: 'MonoRoboto'),),
            ),
          Container(
          height: 600,
          width: double.infinity,
          child: ListView.builder(
          itemCount: Users.length,
          itemBuilder: (BuildContext context, int index) {
          return ListTile(
          title: GestureDetector(
          onTap: (){
          },
          child: Container(
          width: 1000,
          height: 160,
          child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(image: NetworkImage(Users[index].Profilepic),fit: BoxFit.cover),
          ),
          ),
          Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
          Users[index].Name,
          style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'MonoRoboto'),
          ),
          Text(
         Users[index].currentplace,
          style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'MonoRoboto'),
          ),
          Text(
          Users[index].Email,
          style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'MonoRoboto'),
          ),
          Text(
          Users[index].Mobile_no,
          style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'MonoRoboto'),
          ),

          ],

          ),
          ),
          ],
          ),
          ),
          ),
          ),
          );
          },
          ),
          ),
          ],
          ),
          );
      }
      return Homepage();
        }
    );
  }
}
