import 'dart:typed_data';

import 'package:dio/src/multipart_file.dart';

import 'package:dio/src/response.dart';
import 'package:image_picker/image_picker.dart';

import 'package:todo_api/src/model/default_response.dart';
import 'package:todo_api/todo_api.dart';

import '../file.upload.service.dart';

class FileUploadServiceIml extends FileUploadService {
  FileUploadApi fileUploadApi = TodoApi().getFileUploadApi();

  @override
  Future<Response<DefaultResponse>> uploadProfileImage({XFile? profileImage}) async {
    final image = await MultipartFile.fromFile(profileImage!.path);
    return fileUploadApi.uploadProfileImage(userId: api.getAccountId(), profileImage: image);
  }

  @override
  Future<Response<Uint8List>> loadProfileImage() {
    return fileUploadApi.loadProfileImage(userId: api.getAccountId());
  }
}