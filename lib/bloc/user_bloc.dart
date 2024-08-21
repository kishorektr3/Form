import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is FetchUsers) {
      yield UserLoading();
      try {
        final response = await http.get(
            Uri.parse("https://6672ce236ca902ae11b1e111.mockapi.io/form_user"));
        if (response.statusCode == 200) {
          final users = json.decode(response.body);
          yield UserLoaded(users);
        } else {
          yield UserFailure("Failed to fetch users");
        }
      } catch (e) {
        yield UserFailure("Error fetching users");
      }
    } else if (event is AddUser) {
      try {
        final response = await http.post(
          Uri.parse("https://6672ce236ca902ae11b1e111.mockapi.io/form_user"),
          headers: {"Content-Type": "application/json"},
          body: json.encode(event.user),
        );
        if (response.statusCode == 201) {
          add(FetchUsers());
        } else {
          yield UserFailure("Failed to add user");
        }
      } catch (e) {
        yield UserFailure("Error adding user");
      }
    } else if (event is UpdateUser) {
      try {
        final response = await http.put(
          Uri.parse(
              "https://6672ce236ca902ae11b1e111.mockapi.io/form_user/${event.user['id']}"),
          headers: {"Content-Type": "application/json"},
          body: json.encode(event.user),
        );
        if (response.statusCode == 200) {
          add(FetchUsers());
        } else {
          yield UserFailure("Failed to update user");
        }
      } catch (e) {
        yield UserFailure("Error updating user");
      }
    }
  }
}
