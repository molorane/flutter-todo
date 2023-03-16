import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/util/awesome.dialog.util.dart';

import '../../../provider/user.profile.provider.dart';
import '../../../theme/colors.dart';

class ProfilePic extends ConsumerStatefulWidget {
  @override
  _ProfilePic createState() => _ProfilePic();
}

class _ProfilePic extends ConsumerState<ProfilePic> {
  final ImagePicker picker = ImagePicker();

  Future<void> getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    var userProfileDataProvider = ref.read(userProfileStateProvider.notifier);
    userProfileDataProvider.uploadProfile(img);
    AwesomeDialogUtil.success(
        context, "Uploaded", "Your profile picture uploaded!");
  }

  void chooseMediaAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media source'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: primary,
                        padding: const EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor: profileItem,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        getImage(ImageSource.gallery);
                      },
                      child: Row(
                        //Center Column contents horizontally,
                        children: [
                          Icon(Icons.image, weight: 50),
                          const SizedBox(width: 15),
                          Expanded(child: Text("Gallery"))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: primary,
                        padding: const EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor: profileItem,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        getImage(ImageSource.camera);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.camera, weight: 50),
                          const SizedBox(width: 15),
                          Expanded(child: Text("Camera"))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var userProfileDataProvider = ref.watch(userProfileStateProvider);

    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          userProfileDataProvider.when(
              data: (data) {
                return CircleAvatar(
                  backgroundImage: data.profileImage!.image,
                );
              },
              error: (err, s) {
                return CircleAvatar(
                  backgroundImage: AssetImage("assets/error.png"),
                );
              },
              loading: () => Center(child: CircularProgressIndicator())),
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
