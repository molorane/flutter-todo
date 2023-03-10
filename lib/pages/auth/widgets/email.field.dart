import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants.dart';
import '../../task/notifier/auth.user.state.notifier.dart';

class EmailFormField extends ConsumerWidget {
  const EmailFormField({super.key});

  String? validateEmail(String value) {
    if (value != null || value.isNotEmpty) {
      final RegExp regex = RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)| (\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
      if (!regex.hasMatch(value)) {
        return 'Please enter valid email';
      }
      return null;
    } else {
      return 'Please enter email';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var field = ref.watch(authUserStateNotifier);
    String email = field.email ?? '';

    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'OpenSans',
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(top: 14.0),
        prefixIcon: Icon(
          Icons.email,
          color: Colors.white,
        ),
        hintText: 'Enter your Email',
        hintStyle: kHintTextStyle,
      ),
      onSaved: (newValue) {
        ref.read(authUserStateNotifier.notifier).setEmail(newValue!);
      },
      initialValue: email,
      validator: (email) {
        return validateEmail(email!);
      },
    );
  }
}
