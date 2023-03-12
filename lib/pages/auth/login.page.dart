import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/pages/auth/widgets/email.field.dart';
import 'package:todo/pages/auth/widgets/password.field.dart';
import 'package:todo/pages/auth/widgets/social.button.dart';
import 'package:todo/pages/landing/landing.page.dart';
import 'package:todo/pages/routes/home.page.route.dart';
import 'package:todo/theme/colors.dart';

import '../../constants.dart';
import '../../service/AuthService.dart';
import '../task/notifier/auth.user.state.notifier.dart';

class LoginPage extends ConsumerStatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;

  Future<void> signIn() async {
    final authUser = ref.read(authUserStateNotifier.notifier);
    try {
      var auth = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: authUser.getUser().email!,
          password: authUser.getUser().password!);
      print(auth.user);
    } on FirebaseAuthException catch (ex) {
      authUser.setError(ex.message!);
    }
  }

  String errorMessage() {
    final authUser = ref.read(authUserStateNotifier.notifier);
    if (authUser.getUser().authError != null) {
      return authUser.getUser().authError!.message!;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final authUser = ref.watch(authUserStateNotifier);

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Form(
                  key: _formKey,
                  child: Container(
                    height: double.infinity,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.0,
                        vertical: 120.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Email',
                                style: kLabelStyle,
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: kBoxDecorationStyle,
                                height: 60.0,
                                child: EmailFormField(),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Password',
                                style: kLabelStyle,
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: kBoxDecorationStyle,
                                height: 60.0,
                                child: PasswordFormField(),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () => print('Sign Up Button Pressed'),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Forgot password',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 20.0,
                            child: Row(
                              children: <Widget>[
                                Theme(
                                  data: ThemeData(
                                      unselectedWidgetColor: Colors.white),
                                  child: Checkbox(
                                    value: _rememberMe,
                                    checkColor: Colors.green,
                                    activeColor: Colors.white,
                                    onChanged: (value) {
                                      setState(() {
                                        _rememberMe = value!;
                                      });
                                    },
                                  ),
                                ),
                                Text(
                                  'Remember me',
                                  style: kLabelStyle,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  signIn();
                                  ref
                                      .watch(authUserStateNotifier.notifier)
                                      .resetForm();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePageRouting(),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                height: 60,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(17),
                                  color: navBar,
                                ),
                                child: Center(
                                    child: Text("Login",
                                        style: TextStyle(
                                            fontFamily: "Cerebri Sans",
                                            fontSize: 20,
                                            color: Colors.white))),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Visibility(
                              visible: authUser.authError != null,
                              child: Container(
                                padding: EdgeInsets.only(left: 30),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      errorMessage(),
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'Sign in with',
                                style: kLabelStyle,
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                SocialButton(
                                  AssetImage(
                                    'assets/social/facebook.jpg',
                                  ),
                                  () => print('Login with Facebook'),
                                ),
                                SocialButton(
                                  AssetImage(
                                    'assets/social/google.jpg',
                                  ),
                                  () async {
                                    UserCredential user =
                                        await AuthService().signInWithGoogle();
                                    print(user);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePageRouting(),
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              AuthService().signInWithFacebook();
                              print('Sign Up Button Pressed');
                            },
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Don\'t have an Account? ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Sign Up',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LandingPage(),
                                ),
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Back',
                                    style: TextStyle(
                                      color: navBar,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
