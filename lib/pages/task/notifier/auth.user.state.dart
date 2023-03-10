import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth.user.state.freezed.dart';

@Freezed()
abstract class AuthUserState with _$AuthUserState {
  const factory AuthUserState(
      {@Default(null) String? email,
      @Default(null) String? password,
      @Default("") String username}) = _AuthUserState;

  const AuthUserState._();
}
