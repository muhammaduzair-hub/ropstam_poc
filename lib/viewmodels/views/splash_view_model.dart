import 'package:flutter/material.dart';

import '../../data/repository/auth_repository.dart';
import '../../ui/views/auth_view/signin_signup_view.dart';
import '../../ui/views/home/home_screen.dart';
import '../base_model.dart';

class SplashViewModel extends BaseModel {
  late final AuthRepository _repo;

  SplashViewModel({required AuthRepository repository})
      : _repo = repository,
        super(false);

  void checkAlreadyLogin(BuildContext context) async {
    await _repo.checkAlreadyLogin().then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => value ? HomeScreen() : SignInSignUpView(),
          ),
          (route) => false);
    });
  }
}
