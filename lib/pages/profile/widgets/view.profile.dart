import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ViewProfile extends StatelessWidget {
  final ImageProvider<Object> image;

  const ViewProfile({required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.black,
                )),
            elevation: 0.2,
            title: new Text("Profile Photo")),
        body: Container(
            child: PhotoView(
          imageProvider: image,
        )));
  }
}
