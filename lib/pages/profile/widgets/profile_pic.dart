import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePic extends StatefulWidget {
  @override
  _ProfilePic createState() => _ProfilePic();
}

class _ProfilePic extends State<ProfilePic> {
  XFile? image;

  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
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
          image == null
              ? const CircleAvatar(
                  backgroundImage: AssetImage("assets/mothusi.jpeg"),
                )
              : CircleAvatar(
                  backgroundImage: AssetImage(image!.path),
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
