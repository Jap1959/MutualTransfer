import 'package:connect2prof/bloc/events.dart';
import 'package:connect2prof/bloc/statesofapp.dart';
import 'package:connect2prof/databaseservices/GetChatData.dart';
import 'package:connect2prof/usermodel/usermodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ChatPageBLoc.dart';

class BlocChatPage extends Bloc<AppEvent, AppStates> {
  String formatTimeAgo(int milliseconds) {
    DateTime currentTime = DateTime.now();
    DateTime convertedTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);

    Duration difference = currentTime.difference(convertedTime);
    print(milliseconds);
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      int weeks = (difference.inDays / 7).floor();
      return '${weeks} week${weeks > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 365) {
      int months = (difference.inDays / 30).floor();
      return '${months} month${months > 1 ? 's' : ''} ago';
    } else {
      int years = (difference.inDays / 365).floor();
      return '${years} year${years > 1 ? 's' : ''} ago';
    }
  }

  BlocChatPage() : super(ChatLoadState()) {
    Stream<AppStates> mapEventToState(ChatLoadEvent event) async* {
      if (event is ChatLoadEvent) {
        try {
          // Fetch the chat list from the database
          GetChatData _getdata = GetChatData();
          List<UserDatamodel> users = await _getdata.ChatLists();
          emit(ChatLoadedState(users));
        } catch (e) {
          // Handle any errors and emit an error state if necessary
          print(e.toString());
        }
      }
    }

    on<ChatLoadEvent>((event, emit) async {
      try {
        GetChatData _getdata = GetChatData();
        List<UserDatamodel> users = await _getdata.ChatLists();
        emit(ChatLoadedState(users));
      } catch (e) {
        print(e.toString());
      }
    });
    on<SearchEvent>((event, emit) async {
      try {
        GetChatData _getdata = GetChatData();
        final List<UserDatamodel> user = await _getdata.ChatLists();
        List<UserDatamodel> results = user
            .where((user) => user.Name.toLowerCase()
                .contains(event.searchvalue.toLowerCase()))
            .toList();
        if (event.searchvalue == "") {
          emit(SearchResultStateforchat(user));
        }
        emit(SearchResultStateforchat(results));
        print(results.length);
      } catch (e) {
        print(e.toString());
      }
    });
  }
}
