


import 'package:connect2prof/CustomWidgets/ButtonAPP.dart';
import 'package:connect2prof/CustomWidgets/Colors.dart';
import 'package:connect2prof/pages/Loginpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../CustomWidgets/TextDesign.dart';

class WelcomeScrenn extends StatefulWidget {
  const WelcomeScrenn({Key? key}) : super(key: key);

  @override
  State<WelcomeScrenn> createState() => _WelcomeScrennState();
}

class _WelcomeScrennState extends State<WelcomeScrenn> {
  late PageController _pageController;
  List<String> images = [
    "https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg",
    "https://wallpaperaccess.com/full/2637581.jpg",
    "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg"
  ];
  late  var activepage=0;
  late  var getstarted=0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1);
  }
  @override
  Widget build(BuildContext context) {
    final HEIGHT=MediaQuery.of(context).size.height;
    final WIDTH=MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
        SizedBox(
          height: HEIGHT*0.85 ,
          width: WIDTH,
          child:  Container(
                  height: HEIGHT*0.85 ,
                  width: WIDTH,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40.0),
                        bottomLeft: Radius.circular(40.0)),
                    image:DecorationImage(image: NetworkImage(images[activepage]),fit: BoxFit.cover),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 40),
                      child: Row(
                        children: indicators(images.length,activepage ),
                      ),
                    ),
                  ),
                ),
        ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    activepage=activepage+1;
                    if(activepage>=images.length-1){
                      getstarted=1;
                    }
                  });

                },
                child: getstarted==0?ButtonAPP(Name: 'Next',icon: Icons.arrow_forward,):GestureDetector(
                  onTap: (){
                    Get.to(()=>LoginPage());
                  },
                  child: ButtonAPP(Name: 'Get Started',icon: Icons.arrow_forward,),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
