


import 'package:connect2prof/authentication/auth.dart';
import 'package:connect2prof/usermodel/PostdataModel.dart';
import 'package:connect2prof/usermodel/usermodel.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class AppStates extends Equatable{}

class Pageloading extends AppStates{
  List<Object?> get props=> [];
}
class WelcomeState extends AppStates{
  List<Object?> get props=> [];
}
class PageLoadedstate extends AppStates{
  PageLoadedstate(this.Data);

  final List<PostdataModel> Data;
  @override
  List<Object?> get props=> [Data];
}

class Pagerrorstate extends AppStates{
  Pagerrorstate(this.error);
  final String error;
  @override
  List<Object?> get props=> [error];
}
 class UserloginedState extends AppStates{
  @override
  List<Object?> get props => [];
}
class UserlogoutSate extends AppStates{
  @override
  List<Object?> get props => [];
}
class DataUploadedState extends AppStates {
  @override
  List<Object?> get props => [];

}
class LoginSucessState extends AppStates {
  @override
  List<Object?> get props => [];

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