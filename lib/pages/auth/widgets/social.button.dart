import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../task/notifier/auth.user.state.notifier.dart';

class SocialButton extends ConsumerWidget {
  final Function onTap;
  final AssetImage image;

  SocialButton(this.image, this.onTap);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskAddState = ref.watch(authUserStateNotifier);
    return GestureDetector(
      onTap: () => onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: image,
          ),
        ),
      ),
    );
  }
}
