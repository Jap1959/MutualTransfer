


import 'package:connect2prof/CustomWidgets/ButtonAPP.dart';
import 'package:connect2prof/pages/Loginpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../CustomWidgets/TextDesign.dart';

class WelcomeScrenn extends StatefulWidget {
  const WelcomeScrenn({Key? key}) : super(key: key);

  @override
  State<WelcomeScrenn> createState() => _WelcomeScrennState();
}

class _WelcomeScrennState extends State<WelcomeScrenn> {
  late PageController _pageController;
  List<String> images = [
    "https://images.unsplash.com/photo-1564522365984-c08ed1f78893?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDZ8fG5ldHdvcmtpbmclMjBldmVudHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1659629824175-56739d1611a2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzF8fGV4cGxvcmUlMjB0ZWNobm9sb2d5fGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1535957998253-26ae1ef29506?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8d29ya3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60"
  ];
  List<String> Itemtag = [
    'Expand Your Network',
    "Explore Oppurinties",
    "Let's Get Started to Find partner To Swap",
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
                      child: Column(
                       mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(Itemtag[activepage],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'MonoRoboto',fontSize: 25),),
                          ),
                          Row(
                            children: indicators(images.length,activepage ),
                          ),
                        ],
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
