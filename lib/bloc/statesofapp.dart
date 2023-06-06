


import 'package:connect2prof/authentication/auth.dart';
import 'package:connect2prof/usermodel/PostUploadDatamodel.dart';
import 'package:connect2prof/usermodel/PostdataModel.dart';
import 'package:connect2prof/usermodel/usermodel.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../usermodel/MessageDatamodel.dart';
import '../usermodel/NotificationDatamodel.dart';
import '../usermodel/Notificationgetdatamodel.dart';

abstract class AppStates {}

class Pageloading extends AppStates{
  List<Object?> get props=> [];
}
class WelcomeState extends AppStates{
  List<Object?> get props=> [];
}
class NotificationLoadedState extends AppStates{
  NotificationLoadedState(this.notifications);
  List<NotificationGetDatamodel> notifications;
}
class PageLoadedstate extends AppStates{
  PageLoadedstate(this.Data);

  final List<PostdataModel> Data;
  @override
  List<Object?> get props=> [Data];
}
class ProfilePageLoadedstate extends AppStates{
  ProfilePageLoadedstate(this.Data,this.user);
  final UserDatamodel user;
  final List<PostdataModel> Data;
  @override
  List<Object?> get props=> [Data,user];
}
class PagePostLoad extends AppStates{
  String Name;
  String Profilepic;
  String Mobile;
  PagePostLoad(this.Name,this.Profilepic,this.Mobile);
  @override
  List<Object?> get props=> [Name,Profilepic,Mobile];
}

class Pagerrorstate extends AppStates{
  Pagerrorstate(this.error);
  final String error;
  @override
  List<Object?> get props=> [error];
}
 class UserloginedState extends AppStates{
  int noticount;
  UserloginedState(this.noticount);
  @override
  List<Object?> get props => [];
}
class UserFirstTimeState extends AppStates{
  @override
  List<Object?> get props =>[];

}
class UserlogoutSate extends AppStates{
  @override
  List<Object?> get props => [];
}
class WelcomeScreenSate extends AppStates{
  @override
  List<Object?> get props => [];
}
class DataUploadedState extends AppStates {
  DataUploadedState(this.noticount);
  int noticount;
  @override
  List<Object?> get props => [];

}
class LoginSucessState extends AppStates {
  int noticount;
  LoginSucessState(this.noticount);

}
class LinkSentState extends AppStates{

}
class AddedState extends AppStates{
  int notiount;
  AddedState(this.notiount);
}
class SearchingState extends AppStates {

}

class SearchResultState extends AppStates {
  SearchResultState(this.Data);
  final List<PostdataModel> Data;
}
class SearchResultStateforchat extends AppStates {
  SearchResultStateforchat(this.Data);
  final List<UserDatamodel> Data;
}
class ChatLoadState extends AppStates{
}
class ChatLoadedState extends AppStates{
  List<UserDatamodel> data;
  ChatLoadedState(this.data);
}
class MessageLoadedSate extends AppStates{
     List<MessageDatamodel> message;
     MessageLoadedSate(this.message);
}
class ButtonPressedState extends AppStates {
  @override
  List<Object?> get props => [];

}
class ButtonNotPressedState extends AppStates {
  @override
  List<Object?> get props => [];

}
class LoginUnsucessfullState extends AppStates{
  final String Error;
  LoginUnsucessfullState(this.Error);
  @override
  List<Object?> get props => [Error];

}
class UploadStartState extends AppStates{
  @override
  List<Object?> get props => [];
}
class UploadCompleted extends AppStates{
  UploadCompleted(this.url);
  final String url;
  @override
  List<Object?> get props => [url];
}