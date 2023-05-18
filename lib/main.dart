import 'package:connect2prof/CustomWidgets/Colors.dart';
import 'package:connect2prof/bloc/appbloc.dart';
import 'package:connect2prof/pages/WelcomeScreen.dart';
import 'package:connect2prof/pages/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

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
      home: MultiBlocProvider(providers: [BlocProvider(create: (context)=>Blocusage()),BlocProvider(create: (context)=>BlocAddData()),], child: SplashScreen()),
    ) ;
  }
}


