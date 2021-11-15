abstract class EditProfileEvent {}

class EditProfileUsernameChanged extends EditProfileEvent {
  final String? username;

  EditProfileUsernameChanged(this.username);
}

class EditProfileEmailChanged extends EditProfileEvent {
  final String? email;

  EditProfileEmailChanged({this.email});
}

class EditProfilePrefsChanged extends EditProfileEvent {
  final List<String>? prefs;

  EditProfilePrefsChanged(this.prefs);
}

class EditProfileSubmitted extends EditProfileEvent {}
