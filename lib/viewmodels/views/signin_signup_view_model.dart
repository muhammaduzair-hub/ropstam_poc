import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:ropstam_poc/constants/strings.dart';
import 'package:ropstam_poc/constants/toast_util.dart';
import 'package:ropstam_poc/ui/views/home/home_screen.dart';

import '../../data/repository/auth_repository.dart';
import '../base_model.dart';

class SignInSignUpViewModel extends BaseModel {
  late final AuthRepository _repo;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  bool nameState = true;
  bool passState = true;
  bool emailState = true;
  bool phoneState = true;
  bool error = false;
  bool duplicateEmail = false;
  bool duplicatePhone = false;

  SignInSignUpViewModel({
    required AuthRepository repo,
  }) : super(false) {
    _repo = repo;
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  bool validateMobileNumber(String value) {
    bool ans;
    String pattern = r"^(?:(\+92\d{10})|(\d{11}))$";
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      ans = false;
      phoneState = false;
    } else if (!regExp.hasMatch(value)) {
      ans = false;
      phoneState = false;
    } else {
      ans = true;
      phoneState = true;
    }
    setBusy(false);
    return ans;
  }

  validateEmail(String value) {
    //method to check if this email is already existing
    bool ans = EmailValidator.validate(value);
    emailState = ans;
    setBusy(false);
    return ans;
  }

  bool validateName(String value) {
    bool ans;
    String pattern = r'^[a-zA-Z][a-zA-Z\s]+[a-zA-Z]$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      ans = false;
      nameState = false;
    } else if (!regExp.hasMatch(value)) {
      nameState = false;
      ans = false;
    } else {
      nameState = true;
      ans = true;
    }

    setBusy(false);
    return ans;
  }

  bool validatePassword(String value) {
    bool ans;
    String pattern = r'^(?=.*[A-Za-z])(?=.*\d)\S{8,}$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      passState = false;
      ans = false;
    } else if (!regExp.hasMatch(value)) {
      ans = false;
      passState = false;
    } else {
      ans = true;
      passState = true;
    }
    setBusy(false);
    return ans;
  }

  Future btnSigninClick(BuildContext context) async {
    validatePassword(passwordController.text);
    validateEmail(emailController.text);
    if (emailState && passState) {
      _repo.signIn(emailController.text, passwordController.text).then((value) {
        if (value) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
              (route) => false);
          ToastUtil.showToast(LabelSignInSuccessfully);
        } else {
          ToastUtil.showToast(labelSignInError);
        }
      });
    }
  }

  Future btnSignupClick(BuildContext context) async {
    setBusy(true);
    duplicateEmail = false;
    duplicatePhone = false;
    validateName(nameController.text);
    validateEmail(emailController.text);
    validateMobileNumber(numberController.text);
    validatePassword(passwordController.text);

    if (nameState && passState && phoneState && emailState) {
      _repo
          .signUp(nameController.text, emailController.text,
              numberController.text, passwordController.text)
          .then((value) {
        if (value == -1)
          duplicateEmail = true;
        else if (value == -2)
          duplicatePhone = true;
        else {
          //key found successfully
          nameController.text = "";
          emailController.text = "";
          numberController.text = "";
          passwordController.text = "";
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
          ToastUtil.showToast(LabelSignUpSuccessfully);
        }
        setBusy(false);
      });
    }
  }

  void btnAlreadyHaveAnAccountClick(PageController _pageController) {
    nameController.text = "";
    emailController.text = "";
    numberController.text = "";
    passwordController.text = "";
    setBusy(false);
    _pageController.previousPage(
        duration: Duration(milliseconds: 700), curve: Curves.ease);
  }

  void btnCreateNewAccountClick(PageController _pageController) {
    emailController.text = passwordController.text = "";
    _pageController.nextPage(
        duration: Duration(milliseconds: 700), curve: Curves.ease);
  }
}
