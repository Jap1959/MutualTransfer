
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Colors.dart';

class ButtonAPP extends StatefulWidget {
   ButtonAPP({required this.Name,this.icon,this.iconpre});
  String Name;
  IconData? icon;
   IconData? iconpre;

  @override
  State<ButtonAPP> createState() => _ButtonAPPState();
}

class _ButtonAPPState extends State<ButtonAPP> {
  @override
  Widget build(BuildContext context) {
    final HEIGHT=MediaQuery.of(context).size.height;
    final WIDTH=MediaQuery.of(context).size.width;
    return Container(
      height: HEIGHT*0.065,
      width:WIDTH,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: kPrimary,
      ),
      child: Center(child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(widget.iconpre,color: Colors.white,),
            Text(widget.Name,style: TextStyle(fontFamily: 'MonoRoboto',color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
            Icon(widget.icon,color: Colors.white,),
          ],
        ),
      )),
    );
  }
}
