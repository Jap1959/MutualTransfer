

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextfieldPassword extends StatefulWidget {
  TextfieldPassword({required this.Password,required this.HintText});
  TextEditingController Password=TextEditingController();
  String HintText;

  @override
  State<TextfieldPassword> createState() => _TextfieldPasswordState();
}

class _TextfieldPasswordState extends State<TextfieldPassword> {
  bool passwordVisiblemain=false;
  @override
  Widget build(BuildContext context) {

    return Container(
      width: 550,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[100],
      ),
      child: TextFormField(
        controller: widget.Password,
        cursorColor: Colors.black,
        obscureText: passwordVisiblemain,
        enableSuggestions: true,
        decoration: InputDecoration(
          hintText: widget.HintText,
          hintStyle: TextStyle(color:Colors.grey[500]),
          suffixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10),
            child: IconButton(
              icon: Icon(passwordVisiblemain==true
                  ? Icons.visibility
                  : Icons.visibility_off),
              onPressed: () {
                setState(
                      () {
                    passwordVisiblemain = !passwordVisiblemain;
                  },
                );
              },
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
        keyboardType: TextInputType.visiblePassword,
      ),
    );
  }
}
