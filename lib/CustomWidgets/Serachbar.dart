


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({required this.Hintext,required this.color,required this.controller});
  final String Hintext;
  final Color color;
  final TextEditingController controller;

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 550,
      height:45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.color,
      ),
      child: TextFormField(
        controller: widget.controller,
        cursorColor: Colors.black,
        enableSuggestions: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0.0, 10, 0.0, 10),
          hintText: widget.Hintext,
          hintStyle: TextStyle(color:Colors.grey[500]),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          suffixIcon: Icon(Icons.mic,color: Colors.black,),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder:OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
          focusColor: Colors.black,
        ),
        onChanged:(value) {
          },
      ),
    );
  }
}
