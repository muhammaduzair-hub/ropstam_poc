import 'package:ropstam_poc/data/local/database/local_database.dart';
import 'package:ropstam_poc/data/model/car_model.dart';
import 'package:sembast/sembast.dart';

class HomeApi extends LocalDatabase {
  final String _carStoreName = 'car_store';

  Future<List<RecordSnapshot<int, Map<String, dynamic>>>> getAllCars() async {
    final db = await openDatabase();
    final carStore = intMapStoreFactory.store(_carStoreName);
    final recordSnapshot = await carStore.find(db);
    return recordSnapshot;
  }

  Future<int> addCar(CarModel car) async {
    final db = await openDatabase();
    final carStore = intMapStoreFactory.store(_carStoreName);
    final finder = Finder(filter: Filter.equals('reg_no', car.registrationNo));
    final recordSnapshot = await carStore.findFirst(db, finder: finder);

    if (recordSnapshot != null) {
      await db.close();
      return -1; // car already exist
    }

    final data = car.toMap();
    final key = await carStore.add(db, data);
    await db.close();
    return key;
  }

  Future<int> deleteCar(String regNo) async {
    final db = await openDatabase();
    final carStore = intMapStoreFactory.store(_carStoreName);
    final finder = Finder(filter: Filter.equals('reg_no', regNo));
    final recordSnapshot = await carStore.findFirst(db, finder: finder);

    if (recordSnapshot == null) {
      await db.close();
      return -1; // car does not exist
    }

    return await carStore.delete(db, finder: finder);
  }

  Future<int> updateCar(CarModel car) async {
    final db = await openDatabase();
    final carStore = intMapStoreFactory.store(_carStoreName);
    final finder = Finder(filter: Filter.equals('reg_no', car.registrationNo));
    final recordSnapshot = await carStore.findFirst(db, finder: finder);

    if (recordSnapshot == null) {
      await db.close();
      return -1; // car does not exist
    }

    await carStore.update(db, car.toMap(), finder: finder);
    await db.close();
    return 1;
  }
}
