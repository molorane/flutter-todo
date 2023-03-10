// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'auth.user.state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthUserState {
  String? get email => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  DefaultResponse? get authError => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthUserStateCopyWith<AuthUserState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthUserStateCopyWith<$Res> {
  factory $AuthUserStateCopyWith(
          AuthUserState value, $Res Function(AuthUserState) then) =
      _$AuthUserStateCopyWithImpl<$Res, AuthUserState>;
  @useResult
  $Res call(
      {String? email,
      String? password,
      String username,
      DefaultResponse? authError});
}

/// @nodoc
class _$AuthUserStateCopyWithImpl<$Res, $Val extends AuthUserState>
    implements $AuthUserStateCopyWith<$Res> {
  _$AuthUserStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? password = freezed,
    Object? username = null,
    Object? authError = freezed,
  }) {
    return _then(_value.copyWith(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      authError: freezed == authError
          ? _value.authError
          : authError // ignore: cast_nullable_to_non_nullable
              as DefaultResponse?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AuthUserStateCopyWith<$Res>
    implements $AuthUserStateCopyWith<$Res> {
  factory _$$_AuthUserStateCopyWith(
          _$_AuthUserState value, $Res Function(_$_AuthUserState) then) =
      __$$_AuthUserStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? email,
      String? password,
      String username,
      DefaultResponse? authError});
}

/// @nodoc
class __$$_AuthUserStateCopyWithImpl<$Res>
    extends _$AuthUserStateCopyWithImpl<$Res, _$_AuthUserState>
    implements _$$_AuthUserStateCopyWith<$Res> {
  __$$_AuthUserStateCopyWithImpl(
      _$_AuthUserState _value, $Res Function(_$_AuthUserState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? password = freezed,
    Object? username = null,
    Object? authError = freezed,
  }) {
    return _then(_$_AuthUserState(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      authError: freezed == authError
          ? _value.authError
          : authError // ignore: cast_nullable_to_non_nullable
              as DefaultResponse?,
    ));
  }
}

/// @nodoc

class _$_AuthUserState extends _AuthUserState {
  const _$_AuthUserState(
      {this.email = null,
      this.password = null,
      this.username = "",
      this.authError = null})
      : super._();

  @override
  @JsonKey()
  final String? email;
  @override
  @JsonKey()
  final String? password;
  @override
  @JsonKey()
  final String username;
  @override
  @JsonKey()
  final DefaultResponse? authError;

  @override
  String toString() {
    return 'AuthUserState(email: $email, password: $password, username: $username, authError: $authError)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthUserState &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.authError, authError) ||
                other.authError == authError));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, email, password, username, authError);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthUserStateCopyWith<_$_AuthUserState> get copyWith =>
      __$$_AuthUserStateCopyWithImpl<_$_AuthUserState>(this, _$identity);
}

abstract class _AuthUserState extends AuthUserState {
  const factory _AuthUserState(
      {final String? email,
      final String? password,
      final String username,
      final DefaultResponse? authError}) = _$_AuthUserState;
  const _AuthUserState._() : super._();

  @override
  String? get email;
  @override
  String? get password;
  @override
  String get username;
  @override
  DefaultResponse? get authError;
  @override
  @JsonKey(ignore: true)
  _$$_AuthUserStateCopyWith<_$_AuthUserState> get copyWith =>
      throw _privateConstructorUsedError;
}
