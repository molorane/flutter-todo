import 'dart:typed_data';

import 'package:cross_file_image/cross_file_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/service/user.profile.service.dart';

import '../../../service/impl/user.profile.service.impl.dart';

class ProfilePic extends ConsumerStatefulWidget {
  @override
  _ProfilePic createState() => _ProfilePic();
}

class _ProfilePic extends ConsumerState<ProfilePic> {
  late Image? image;
  final UserProfileService userProfileService = UserProfileServiceImpl();

  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = Image(image: XFileImage(img!));
    });

    userProfileService.uploadProfileImage(profileImage: img);
  }

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  getProfileData() async {
    final Response<Uint8List> profile =
        await userProfileService.loadProfileImage();
    setState(() {
      image = Image.memory(profile.data!);
    });
  }

  void chooseMediaAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        const SizedBox(width: 20),
                        Text('Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        const SizedBox(width: 20),
                        Text('Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: image!.image,
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.white),
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFFF5F6F9),
                ),
                onPressed: () {
                  chooseMediaAlert();
                },
                child: SvgPicture.asset("assets/profile/camera.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
