import 'package:ropstam_poc/data/local/database/local_database.dart';
import 'package:ropstam_poc/data/model/user_model.dart';
import 'package:sembast/sembast.dart';

class AuthApi extends LocalDatabase {
  final String _userStoreName = 'user_store';
  final String _userLogin = 'user_login';

  Future<int> signUp(UserModel user) async {
    final db = await openDatabase();
    final userStore = intMapStoreFactory.store(_userStoreName);
    final finder = Finder(filter: Filter.equals('username', user.email));
    final recordSnapshot = await userStore.findFirst(db, finder: finder);

    if (recordSnapshot != null) {
      await db.close();
      return -1; // Email already exists
    }

    final phone_finder = Finder(filter: Filter.equals('phoneno', user.phoneno));
    final phone_recordSnapshot =
        await userStore.findFirst(db, finder: phone_finder);
    if (phone_recordSnapshot != null) {
      await db.close();
      return -2; //Phone Already Exist
    }

    final data = user.toJson();
    final key = await userStore.add(db, data);
    await db.close();
    return key;
  }

  Future<dynamic> signIn(String email, String password) async {
    final db = await openDatabase();
    final userStore = intMapStoreFactory.store(_userStoreName);
    final finder = Finder(
        filter: Filter.and([
      Filter.equals('username', email),
      Filter.equals('password', password),
    ]));
    final recordSnapshot = await userStore.findFirst(db, finder: finder);

    if (recordSnapshot == null) {
      await db.close();
      return null; // Login failed
    }

    await db.close();
    return recordSnapshot.value; // Login successful
  }

  Future<int> saveSignInUserInfo(Map<String, Object?> json) async {
    final db = await openDatabase();
    final loginStore = intMapStoreFactory.store(_userLogin);

    await loginStore.add(db, json);
    await db.close();
    return 1;
  }

  Future<List<RecordSnapshot<int, Map<String, dynamic>>>> getLoginUser() async {
    final db = await openDatabase();
    final loginStore = intMapStoreFactory.store(_userLogin);
    final recordSnapshot = await loginStore.find(db);
    return recordSnapshot;
  }
}
