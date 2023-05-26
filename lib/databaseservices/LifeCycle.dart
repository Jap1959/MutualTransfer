

import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'AddchatRoomDetails.dart';

class AppLifecycleObserver with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      AddchatDetails _add=AddchatDetails();
      _add.AddStatus('false');
    }
    else if (state == AppLifecycleState.resumed) {
      AddchatDetails _add=AddchatDetails();
      _add.AddStatus('true');
    }
  }

}