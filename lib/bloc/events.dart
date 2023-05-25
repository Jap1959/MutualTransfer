
import 'package:connect2prof/CustomWidgets/ButtonAPP.dart';
import 'package:connect2prof/usermodel/PostdataModel.dart';
import 'package:connect2prof/usermodel/usermodel.dart';
import 'package:equatable/equatable.dart';

import '../usermodel/PostUploadDatamodel.dart';

abstract class AppEvent {
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
  final PostUploaddataModel? Post;
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
class ProfilePageEvent extends AppEvent{
  List<Object> get props=>[];
}
class LoginPageEvent extends AppEvent{
   final String Email;
   final String password;
   LoginPageEvent(this.Email,this.password);
  List<Object> get props=>[Email,password];
}
class ResetPasswordEvent extends AppEvent{
  final String Email;
  ResetPasswordEvent(this.Email) ;
  List<Object> get props=>[];
}
class SinupPageEvent extends AppEvent{
  final String Email;
  final String password;
  SinupPageEvent(this.Email,this.password);
  List<Object> get props=>[Email,password];
}
class PostLoadEvent extends AddPostEvent{
  final PostUploaddataModel? Post;
  PostLoadEvent(this.Post) : super(null);
  List<Object> get props=>[];
}
class ProfileUpdateEvent extends AdddataEvent{
  final UserDatamodel? user;
  ProfileUpdateEvent(this.user):super(null);
  List<Object> get props=>[];
}
class SearchEvent extends AppEvent{
  SearchEvent(this.searchvalue);
  final String searchvalue;
}
class ProfileUploadEvent extends AdddataEvent{
  ProfileUploadEvent(this.filename,this.path) : super(null);
  final String path;
  final String filename;
  List<Object> get props=>[path,filename];
}
class ChatLoadEvent extends AppEvent{
  List<Object> get props=>[];
}
class NotificationLoadEvent extends AppEvent{

}