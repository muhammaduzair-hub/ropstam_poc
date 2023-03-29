import 'dart:async';

import 'package:ropstam_poc/data/model/user_model.dart';

import '../local/auth_api.dart';

class AuthRepository {
  final AuthApi localApi;

  AuthRepository({required AuthApi localApi}) : localApi = localApi;

  StreamController<UserModel> _userController = StreamController<UserModel>();
  Stream<UserModel> get user => _userController.stream;

  Future<int> signUp(
      String name, String email, String number, String password) {
    UserModel user = UserModel(
        id: "", email: email, name: name, password: password, phoneno: number);

    localApi.saveSignInUserInfo(user.toJson());
    return localApi.signUp(user);
  }

  Future<bool> signIn(String email, String password) {
    return localApi.signIn(email, password).then((value) {
      if (value == null) {
        return false;
      } else {
        _userController.add(UserModel.fromJson(value));
        localApi.saveSignInUserInfo(value);
        return true;
      }
    });
  }

  Future<bool> checkAlreadyLogin() async {
    List<UserModel> users = [];
    await localApi.getLoginUser().then((value) {
      users = value.map((e) => UserModel.fromJson(e.value)).toList();
    });
    return users.isNotEmpty;
  }
}
