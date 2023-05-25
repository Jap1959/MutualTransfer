


import 'package:connect2prof/CustomWidgets/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationTiles extends StatelessWidget {
  final String title, subtitle,url;
  const NotificationTiles({
   required this.title, required this.subtitle, required this.url,
  }) ;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
          height: 50.0,
          width: 50.0,
          decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover))),
      title: Text(title, style: TextStyle(color:kPrimary)),
      subtitle: Text(subtitle,
          style: TextStyle(color: Colors.black)),
    );
  }
}