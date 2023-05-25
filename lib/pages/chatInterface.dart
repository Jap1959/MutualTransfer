


import 'package:connect2prof/CustomWidgets/Colors.dart';
import 'package:connect2prof/CustomWidgets/Serachbar.dart';
import 'package:connect2prof/bloc/events.dart';
import 'package:connect2prof/pages/ChannelPage.dart';
import 'package:connect2prof/pages/Homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../bloc/ChatPageBLoc.dart';
import '../bloc/statesofapp.dart';

class ChatInterface extends StatefulWidget {

  @override
  State<ChatInterface> createState() => _ChatInterfaceState();
}

class _ChatInterfaceState extends State<ChatInterface> {
  TextEditingController search=new TextEditingController();
  BlocChatPage _blocChatPage=BlocChatPage();
  @override
  void initState() {
    _blocChatPage.add(ChatLoadEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Height=MediaQuery.of(context).size.height;
    final Width=MediaQuery.of(context).size.width;
    return BlocBuilder<BlocChatPage, AppStates>(
        bloc: _blocChatPage,
        builder: (context, state)
    {
      if(state is ChatLoadState){
        return Center(
          child: CircularProgressIndicator(
            color: kPrimary,
          ),
        );
      }
      if(state is ChatLoadedState){
        return Center();
      }
      return Container();
    });
    }
}
