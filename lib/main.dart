import 'package:connect2prof/CustomWidgets/Colors.dart';
import 'package:connect2prof/bloc/HomepageBloc.dart';
import 'package:connect2prof/bloc/LoginPageBLoc.dart';
import 'package:connect2prof/bloc/PostPageBLoc.dart';
import 'package:connect2prof/bloc/ProfileLoadBloc.dart';
import 'package:connect2prof/bloc/ChatPageBLoc.dart';
import 'package:connect2prof/pages/WelcomeScreen.dart';
import 'package:connect2prof/pages/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/AdddataBloc.dart';
import 'bloc/SinupPageBLoc.dart';
import 'bloc/SplashScreenBloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const C2P());
}
class C2P extends StatelessWidget {
  const C2P({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MutualTransfer',
      theme: ThemeData(primarySwatch:Colors.teal,
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider(create: (context)=>Blocusage()),
        BlocProvider(create: (context)=>BlocAddData()),
        BlocProvider(create: (context)=>BlocHompage()),
        BlocProvider(create: (context)=>ProfileLoad()),
        BlocProvider(create: (context)=>BlocLogin()),
        BlocProvider(create: (context)=>BlocSingUp()),
        BlocProvider(create: (context)=>BlocPostAdd()),


      ],
          child: SplashScreen()),
    ) ;
  }
}


