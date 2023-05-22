
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Colors.dart';

class LoadingButton extends StatefulWidget {
  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
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
        child:SpinKitThreeBounce(color: Colors.white,),
      )),
    );
  }
}
