import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_api/todo_api.dart';

import '../service/impl/user.profile.service.impl.dart';
import '../service/user.profile.service.dart';

part 'user.profile.provider.freezed.dart';

// Creating state where the freezed annotation will suggest that boilerplate code needs to be generated
@Freezed()
abstract class UserProfileState with _$UserProfileState {
  const factory UserProfileState() = _UserProfileState;

  const UserProfileState._();
}

// Creating state notifier provider
final userProfileStateProvider =
    AsyncNotifierProvider<UserProfileStateNotifier, UserProfileState>(
        UserProfileStateNotifier.new);

// Creating Notifier
class UserProfileStateNotifier extends AsyncNotifier<UserProfileState> {
  final UserProfileService fileUploadService = UserProfileServiceImpl();

  // loadTasks
  @override
  FutureOr<UserProfileState> build() async {
    state = AsyncValue.data(UserProfileState());
    return state.value!;
  }

  uploadProfile(XFile? img) async {
    state = AsyncLoading();
    AsyncValue<Response<DefaultResponse>> av = await AsyncValue.guard(
        () async => fileUploadService.uploadProfileImage(profileImage: img));
    state = AsyncData(UserProfileState());
  }
}
