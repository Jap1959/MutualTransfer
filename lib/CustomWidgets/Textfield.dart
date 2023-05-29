import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextfieldApp extends StatefulWidget {
  TextfieldApp(
      {required this.Email,
      required this.HintText,
      this.icon,
      required this.color,
      this.focusnode});
  TextEditingController Email = TextEditingController();
  String HintText;
  IconData? icon;
  Color color;
  FocusNode? focusnode;

  @override
  State<TextfieldApp> createState() => _TextfieldAppState();
}

class _TextfieldAppState extends State<TextfieldApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 550,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: widget.color,
      ),
      child: TextFormField(
        controller: widget.Email,
        cursorColor: Colors.black,
        focusNode: widget.focusnode,
        enableSuggestions: true,
        decoration: InputDecoration(
          hintText: widget.HintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
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
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
          focusColor: Colors.black,
        ),
      ),
    );
  }
}
