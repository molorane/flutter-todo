// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user.account.provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserAccountState {
  Image? get profileImage => throw _privateConstructorUsedError;
  AccountDTO? get account => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserAccountStateCopyWith<UserAccountState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserAccountStateCopyWith<$Res> {
  factory $UserAccountStateCopyWith(
          UserAccountState value, $Res Function(UserAccountState) then) =
      _$UserAccountStateCopyWithImpl<$Res, UserAccountState>;
  @useResult
  $Res call({Image? profileImage, AccountDTO? account});
}

/// @nodoc
class _$UserAccountStateCopyWithImpl<$Res, $Val extends UserAccountState>
    implements $UserAccountStateCopyWith<$Res> {
  _$UserAccountStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profileImage = freezed,
    Object? account = freezed,
  }) {
    return _then(_value.copyWith(
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as Image?,
      account: freezed == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as AccountDTO?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserAccountStateCopyWith<$Res>
    implements $UserAccountStateCopyWith<$Res> {
  factory _$$_UserAccountStateCopyWith(
          _$_UserAccountState value, $Res Function(_$_UserAccountState) then) =
      __$$_UserAccountStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Image? profileImage, AccountDTO? account});
}

/// @nodoc
class __$$_UserAccountStateCopyWithImpl<$Res>
    extends _$UserAccountStateCopyWithImpl<$Res, _$_UserAccountState>
    implements _$$_UserAccountStateCopyWith<$Res> {
  __$$_UserAccountStateCopyWithImpl(
      _$_UserAccountState _value, $Res Function(_$_UserAccountState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profileImage = freezed,
    Object? account = freezed,
  }) {
    return _then(_$_UserAccountState(
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as Image?,
      account: freezed == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as AccountDTO?,
    ));
  }
}

/// @nodoc

class _$_UserAccountState extends _UserAccountState {
  const _$_UserAccountState({this.profileImage = null, this.account = null})
      : super._();

  @override
  @JsonKey()
  final Image? profileImage;
  @override
  @JsonKey()
  final AccountDTO? account;

  @override
  String toString() {
    return 'UserAccountState(profileImage: $profileImage, account: $account)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserAccountState &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.account, account) || other.account == account));
  }

  @override
  int get hashCode => Object.hash(runtimeType, profileImage, account);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserAccountStateCopyWith<_$_UserAccountState> get copyWith =>
      __$$_UserAccountStateCopyWithImpl<_$_UserAccountState>(this, _$identity);
}

abstract class _UserAccountState extends UserAccountState {
  const factory _UserAccountState(
      {final Image? profileImage,
      final AccountDTO? account}) = _$_UserAccountState;
  const _UserAccountState._() : super._();

  @override
  Image? get profileImage;
  @override
  AccountDTO? get account;
  @override
  @JsonKey(ignore: true)
  _$$_UserAccountStateCopyWith<_$_UserAccountState> get copyWith =>
      throw _privateConstructorUsedError;
}
