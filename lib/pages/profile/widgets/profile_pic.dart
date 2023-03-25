import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/pages/profile/widgets/view.profile.dart';
import 'package:todo/theme/colors.dart';
import 'package:todo/util/awesome.dialog.util.dart';

import '../../../provider/user.account.provider.dart';

class ProfilePic extends ConsumerStatefulWidget {
  @override
  _ProfilePic createState() => _ProfilePic();
}

class _ProfilePic extends ConsumerState<ProfilePic> {
  final ImagePicker picker = ImagePicker();

  Future<void> getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    var userProfileDataProvider = ref.read(userAccountStateProvider.notifier);
    userProfileDataProvider.uploadProfile(img);
    AwesomeDialogUtil.success(
        context, "Uploaded", "Your profile picture uploaded!");
  }

  void showPicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            color: navBar,
            child:SafeArea(
          child: Wrap(
            children: <Widget>[
               Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Gallery'),
                      onTap: () {
                        getImage(ImageSource.gallery);
                        Navigator.of(context).pop();
                      },
                    ),
                    Divider(thickness: 2,),
                    ListTile(
                      leading: const Icon(Icons.photo_camera),
                      title: const Text('Camera'),
                      onTap: () {
                        getImage(ImageSource.camera);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),

            ],
          ),
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var userProfileDataProvider = ref.watch(userAccountStateProvider);

    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          userProfileDataProvider.when(
              data: (data) {
                return OpenContainer(
                    transitionType: ContainerTransitionType.fadeThrough,
                    closedColor: Colors.transparent,
                    closedElevation: 0,
                    transitionDuration: Duration(seconds: 1),
                    closedBuilder: (
                      BuildContext context,
                      VoidCallback action,
                    ) {
                      return CircleAvatar(
                        backgroundImage: data.profileImage!.image,
                      );
                    },
                    openBuilder: (builder, context) {
                      return ViewProfile(image: data.profileImage!.image);
                    });
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
                  showPicker();
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
