
import 'package:connect2prof/databaseservices/AddchatRoomDetails.dart';
import 'package:connect2prof/databaseservices/LifeCycle.dart';
import 'package:connect2prof/pages/Homepage.dart';
import 'package:connect2prof/pages/Loginpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/SplashScreenBloc.dart';
import '../bloc/events.dart';
import '../bloc/statesofapp.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool passwordVisiblemain = false;
  late Blocusage _blocusage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordVisiblemain = true;
    _blocusage = BlocProvider.of<Blocusage>(context);
    _blocusage.add(Userauthenticationevent());
    AddchatDetails _add = AddchatDetails();
     _add.AddStatus('true');
    WidgetsBinding.instance.addObserver(AppLifecycleObserver());
  }

  @override
  Widget build(BuildContext context) {
    final Height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;

    return BlocBuilder<Blocusage, AppStates>(builder: (context, state) {
      if (state is Pageloading) {
        return Scaffold(
         backgroundColor: Colors.white,
          body: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        );
      }
      if (state is UserloginedState) {
        return Homepage(
          noticount: state.noticount,
          index: 0,
        );
      }
      if (state is UserlogoutSate) {
        return LoginPage();
      }
      return Container(
        height: Height,
        width: Width,
        decoration:const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/mtf-logo.png')),
        ),
      );
    });
  }
}
