
import 'package:connect2prof/usermodel/usermodel.dart';
import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable{
  const AppEvent();
}
  class Userauthenticationevent extends AppEvent{
  List<Object> get props=> [];
  
  }
  class AdddataEvent extends AppEvent{
    final UserDatamodel user;
    AdddataEvent(this.user);
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