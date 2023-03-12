import 'dart:async';
import 'dart:typed_data';

import 'package:cross_file_image/cross_file_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

import '../service/impl/user.profile.service.impl.dart';
import '../service/user.profile.service.dart';

part 'user.profile.provider.freezed.dart';

// Creating state where the freezed annotation will suggest that boilerplate code needs to be generated
@Freezed()
abstract class UserProfileState with _$UserProfileState {
  const factory UserProfileState({@Default(null) Image? profileImage}) =
      _UserProfileState;

  const UserProfileState._();
}

// Creating state notifier provider
final userProfileStateProvider =
    AsyncNotifierProvider<UserProfileStateNotifier, UserProfileState>(
        UserProfileStateNotifier.new);

// Creating Notifier
class UserProfileStateNotifier extends AsyncNotifier<UserProfileState> {
  final UserProfileService userProfileService = UserProfileServiceImpl();

  @override
  FutureOr<UserProfileState> build() async {
    state = AsyncLoading();
    final AsyncValue<Response<Uint8List>> av =
        await AsyncValue.guard(() => userProfileService.loadProfileImage());
    state = AsyncValue.data(
        UserProfileState(profileImage: Image.memory(av.value!.data!)));
    return state.value!;
  }

  uploadProfile(XFile? img) async {
    state = AsyncLoading();
    await AsyncValue.guard(
        () async => userProfileService.uploadProfileImage(profileImage: img));
    state = AsyncValue.data(
        UserProfileState(profileImage: Image(image: XFileImage(img!))));
  }

  void loadProfile() async {
    try {
      state = AsyncLoading();
      final AsyncValue<Response<Uint8List>> av =
      await AsyncValue.guard(() => userProfileService.loadProfileImage());
      state = AsyncValue.data(
          UserProfileState(profileImage: Image.memory(av.value!.data!)));
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
    }
  }
}
