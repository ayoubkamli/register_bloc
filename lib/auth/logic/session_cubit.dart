import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/auth/models/user.dart';
import 'package:myapp/auth/repositories/auth_credentials.dart';
import 'package:myapp/auth/repositories/auth_repository.dart';
import 'package:myapp/auth/logic/session_state.dart';
import 'package:myapp/auth/screens/login_view.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthRepository authRepo;

  SessionCubit({required this.authRepo}) : super(UnknownSessionState()) {
    attemptAutoLogin();
  }

  void attemptAutoLogin() async {
    try {
      final userId = await authRepo.attemptAutoLogin();
      //final user = dataRepo.getUser(userId);
      final user = userId;
      emit(Authenticated(user));
    } on Exception {
      emit(Unauthenticated());
    }
  }

  void showAuth() => emit(Unauthenticated());
  void showSession(AuthCredentials credentials) {
    // final user = dataRepo.getUser(credentials.userId);
    final user = credentials.username;
    emit(Authenticated(user));
  }

  void signOut() {
    authRepo.signOut();
    emit(Unauthenticated());
    print('signout from session cubit was called');
    MaterialPageRoute(builder: (_) => LoginView());
  }
}
