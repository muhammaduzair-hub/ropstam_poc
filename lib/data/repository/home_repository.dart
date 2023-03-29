import 'package:ropstam_poc/data/local/home_api.dart';
import 'package:ropstam_poc/data/model/car_model.dart';

class HomeRepository {
  final HomeApi _api;

  HomeRepository({required HomeApi api}) : _api = api;

  Future<List<CarModel>> getAllCars() async {
    List<CarModel> cars = [];
    await _api.getAllCars().then((value) {
      cars = value.map((e) => CarModel.fromJson(e.value)).toList();
    });
    return cars;
  }

  Future<int> addCar(
      {required String title,
      required String model,
      required String category,
      required String color,
      required String regNo}) async {
    CarModel _carModel = CarModel(
        category: category,
        name: title,
        color: color,
        model: model,
        registrationNo: regNo);
    return _api.addCar(_carModel);
  }

  Future<bool> deleteCar(String regNo) async {
    return _api.deleteCar(regNo).then((value) {
      if (value < 0)
        return false;
      else
        return true;
    });
  }

  Future<int> updateCar(
      {required String title,
      required String model,
      required String category,
      required String color,
      required String regNo}) async {
    CarModel _carModel = CarModel(
        category: category,
        name: title,
        color: color,
        model: model,
        registrationNo: regNo);

    int ans = await _api.updateCar(_carModel);
    return ans;
  }
}
