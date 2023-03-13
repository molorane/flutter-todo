import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_api/todo_api.dart';

part 'auth.user.state.freezed.dart';

@Freezed()
abstract class AuthUserState with _$AuthUserState {
  const factory AuthUserState({
    @Default(null) String? email,
    @Default(null) String? password,
    @Default("") String username,
    @Default(null) DefaultResponse? authError,
    @Default(false) bool? startAuthentication,
  }) = _AuthUserState;

  const AuthUserState._();
}
