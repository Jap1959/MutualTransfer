
import 'package:connect2prof/usermodel/PostdataModel.dart';
import 'package:connect2prof/usermodel/usermodel.dart';
import 'package:equatable/equatable.dart';

import '../usermodel/PostUploadDatamodel.dart';

abstract class AppEvent extends Equatable{
  const AppEvent();
}
  class Userauthenticationevent extends AppEvent{
  List<Object> get props=> [];
  
  }
  class AdddataEvent extends AppEvent{
    final UserDatamodel? user;
    AdddataEvent(this.user);
    List<Object> get props=>[];
  }
class AddPostEvent extends AppEvent{
  final PostUploaddataModel Post;
  AddPostEvent(this.Post);
  List<Object> get props=>[];
}
class HomePageDataEvent extends AppEvent{
  List<Object> get props=>[];
}
class UserDetailsPageEvent extends AppEvent{
  List<Object> get props=>[];
}
class MessagesPageEvent extends AppEvent{
  List<Object> get props=>[];
}

class LoginPageEvent extends AppEvent{
   final String Email;
   final String password;
   LoginPageEvent(this.Email,this.password);
  List<Object> get props=>[Email,password];
}
class SinupPageEvent extends AppEvent{
  final String Email;
  final String password;
  SinupPageEvent(this.Email,this.password);
  List<Object> get props=>[Email,password];
}
class ProfileUploadEvent extends AdddataEvent{
  ProfileUploadEvent(this.filename,this.path) : super(null);
  final String path;
  final String filename;
  List<Object> get props=>[path,filename];
}
