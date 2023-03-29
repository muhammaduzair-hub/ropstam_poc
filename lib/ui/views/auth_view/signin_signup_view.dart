import 'package:flutter/material.dart';
import 'package:ropstam_poc/ui/views/auth_view/signin_widget.dart';
import 'package:ropstam_poc/ui/views/auth_view/singup_widget.dart';

class SignInSignUpView extends StatelessWidget {
  SignInSignUpView({Key? key}) : super(key: key);

  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return PageView(
      controller: _pageController,
      children: [
        SignIn(context, size, _pageController),
        signUp(context, size, _pageController),
      ],
    );
  }
}
