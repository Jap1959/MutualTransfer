

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextfieldArea extends StatefulWidget {
  TextfieldArea({required this.Email,required this.HintText, this.icon,required this.color});
  TextEditingController Email=TextEditingController();
  String HintText;
  IconData? icon;
  Color color;

  @override
  State<TextfieldArea> createState() => _TextfieldAreaState();
}

class _TextfieldAreaState extends State<TextfieldArea> {


  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 550,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: widget.color,
      ),
      child: TextFormField(
        controller: widget.Email,
        maxLines: 15,
        keyboardType: TextInputType.multiline,
        cursorColor: Colors.black,
        enableSuggestions: true,
        decoration: InputDecoration(
          hintText: widget.HintText,
          hintStyle: TextStyle(color:Colors.grey[500]),
          prefixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8),
            child: Icon(
              widget.icon,
            ),
          ),
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
      ),
    );
  }
}
