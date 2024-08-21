abstract class UserEvent {}

class FetchUsers extends UserEvent {}

class AddUser extends UserEvent {
  final Map<String, dynamic> user;

  AddUser(this.user);
}

class UpdateUser extends UserEvent {
  final Map<String, dynamic> user;

  UpdateUser(this.user);
}
