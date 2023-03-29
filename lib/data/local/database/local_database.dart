import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class LocalDatabase {
  final String _dbName = 'my_db.db';

  Future<Database> openDatabase() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = appDir.path + '/' + _dbName;
    return await databaseFactoryIo.openDatabase(dbPath);
  }
}
