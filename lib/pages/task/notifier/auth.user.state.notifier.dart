import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/pages/task/notifier/auth.user.state.dart';

final authUserStateNotifier =
    StateNotifierProvider<AuthUserStateNotifier, AuthUserState>((ref) {
  return AuthUserStateNotifier(user: AuthUserState());
});

class AuthUserStateNotifier extends StateNotifier<AuthUserState> {
  AuthUserStateNotifier({required AuthUserState user}) : super(user);

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setUsername(String username) {
    state = state.copyWith(username: username);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  void resetForm() {
    state = AuthUserState();
  }

  AuthUserState getUser() {
    return state;
  }
}
