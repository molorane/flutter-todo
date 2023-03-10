import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants.dart';
import '../../task/notifier/auth.user.state.notifier.dart';

class PasswordFormField extends ConsumerWidget {
  const PasswordFormField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var field = ref.watch(authUserStateNotifier);
    String email = field.password ?? '';

    return TextFormField(
      obscureText: true,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'OpenSans',
      ),
      decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.white,
          ),
          hintText: 'Enter your Password',
          hintStyle: kHintTextStyle,
          errorStyle: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          )),
      onSaved: (newValue) {
        ref.read(authUserStateNotifier.notifier).setPassword(newValue!);
      },
      initialValue: email,
      validator: (description) {
        if (description!.isEmpty) {
          return "Please enter password";
        }
        return null;
      },
    );
  }
}
