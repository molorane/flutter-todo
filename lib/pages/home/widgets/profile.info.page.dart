import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../provider/user.account.provider.dart';

class ProfileInfoPage extends ConsumerStatefulWidget {
  @override
  _ProfileInfoPage createState() => _ProfileInfoPage();
}

class _ProfileInfoPage extends ConsumerState<ProfileInfoPage> {
  final ImagePicker picker = ImagePicker();

  Future<void> getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    var userProfileDataProvider = ref.read(userAccountStateProvider.notifier);
    userProfileDataProvider.uploadProfile(img);
  }

  @override
  Widget build(BuildContext context) {
    var userProfileDataProvider = ref.watch(userAccountStateProvider);

    return userProfileDataProvider.when(data: (data) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.only(right: 10),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: data.profileImage!.image,
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Hello Mothusi',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "Track your daily todos & relax.",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      );
    }, error: (err, s) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.only(right: 10),
              child: GestureDetector(
                  onTap: () {
                    ref.watch(userAccountStateProvider.notifier).loadProfile();
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("assets/error.png"),
                  ))),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Hello',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "Sorry, we could not load a picture.",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      );
    }, loading: () {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.only(right: 10),
              child: CircularProgressIndicator()),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Hello Mothusi',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "Loading profile picture...",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
