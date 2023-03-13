import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/pages/task/notifier/auth.user.state.dart';
import 'package:todo_api/todo_api.dart';

final authUserStateNotifier =
    StateNotifierProvider<AuthUserStateNotifier, AuthUserState>((ref) {
  return AuthUserStateNotifier(user: AuthUserState());
});

class AuthUserStateNotifier extends StateNotifier<AuthUserState> {
  AuthUserStateNotifier({required AuthUserState user}) : super(user);

  void startAuthentication() {
    state = state.copyWith(startAuthentication: true);
  }

  void endAuthentication() {
    state = state.copyWith(startAuthentication: false);
  }

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setUsername(String username) {
    state = state.copyWith(username: username);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  void setError(String message) {
    final DefaultResponseBuilder authError = DefaultResponseBuilder();
    authError.message = message;
    state = state.copyWith(authError: authError.build());
  }

  void resetForm() {
    state = AuthUserState();
  }

  AuthUserState getUser() {
    return state;
  }
}
