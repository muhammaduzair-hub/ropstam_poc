import 'package:flutter/material.dart';
import 'package:ropstam_poc/constants/strings.dart';
import 'package:ropstam_poc/constants/toast_util.dart';
import 'package:ropstam_poc/data/model/car_model.dart';
import 'package:ropstam_poc/data/repository/home_repository.dart';
import 'package:ropstam_poc/viewmodels/base_model.dart';

class HomeViewModel extends BaseModel {
  final HomeRepository _repo;
  HomeViewModel(HomeRepository repo)
      : _repo = repo,
        super(false) {
    getCars();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  final formKey = GlobalKey<FormState>();
  final categoryController = TextEditingController();
  final titleController = TextEditingController();
  final colorController = TextEditingController();
  final modelController = TextEditingController();
  final registrationNoController = TextEditingController();
  List<String> categories = ['Suzuki', 'Honda', 'MG', "Hyundai"];
  String selectedCategory = 'Suzuki';
  List<CarModel> cars = [];

  int? selectedIndexForUpdate;

  bool titleState = false;
  bool colorState = false;
  bool modelState = false;
  bool regState = false;

  bool validateTitle() => titleController.text.isEmpty;
  bool validateColor() => colorController.text.isEmpty;
  bool validateModel() => modelController.text.isEmpty;
  bool validateRedNo() => registrationNoController.text.isEmpty;

  Future getCars() async {
    cars = await _repo.getAllCars();
    setBusy(false);
  }

  getSelectedItemInfo(int index) {
    selectedIndexForUpdate = index;
    selectedCategory = cars[selectedIndexForUpdate!].category!;
    titleController.text = cars[selectedIndexForUpdate!].name!;
    colorController.text = cars[selectedIndexForUpdate!].color!;
    registrationNoController.text =
        cars[selectedIndexForUpdate!].registrationNo!;
    modelController.text = cars[selectedIndexForUpdate!].model!;
    setBusy(false);
  }

  Future addCar(BuildContext context) async {
    titleState = validateTitle();
    colorState = validateColor();
    modelState = validateModel();
    regState = validateRedNo();
    setBusy(true);
    if (!titleState && !colorState && !modelState && !regState) {
      _repo
          .addCar(
              title: titleController.text,
              model: modelController.text,
              category: selectedCategory,
              color: colorController.text,
              regNo: registrationNoController.text)
          .then((value) {
        if (value > 1) {
          cars.add(CarModel(
              name: titleController.text,
              model: modelController.text,
              category: selectedCategory,
              color: colorController.text,
              registrationNo: registrationNoController.text));
          titleController.text = modelController.text =
              colorController.text = registrationNoController.text = "";

          titleState = colorState = modelState = regState = false;

          Navigator.pop(context);
          setBusy(false);
        } else {
          ToastUtil.showToast("Car Already Exists");
        }
      });
    }
    setBusy(false);
  }

  Future deleteCar(String regNo) async {
    await _repo.deleteCar(regNo).then((value) {
      if (value) {
        cars.removeWhere((element) => element.registrationNo == regNo);
        ToastUtil.showToast(labelCarsDeleteToast);
      } else {
        ToastUtil.showToast(labelCarNotFound);
      }
    });
    setBusy(false);
  }

  Future updateCar(BuildContext context) async {
    titleState = validateTitle();
    colorState = validateColor();
    modelState = validateModel();
    regState = validateRedNo();
    setBusy(true);
    if (selectedIndexForUpdate != null &&
        !titleState &&
        !colorState &&
        !modelState &&
        !regState) {
      _repo
          .updateCar(
              title: titleController.text,
              model: modelController.text,
              category: selectedCategory,
              color: colorController.text,
              regNo: registrationNoController.text)
          .then((value) {
        if (value > 0) {
          cars[selectedIndexForUpdate!].name = titleController.text;
          cars[selectedIndexForUpdate!].model = modelController.text;
          cars[selectedIndexForUpdate!].color = colorController.text;
          cars[selectedIndexForUpdate!].category = selectedCategory;

          titleController.text = modelController.text =
              colorController.text = registrationNoController.text = "";

          titleState = colorState = modelState = regState = false;
          Navigator.pop(context);
          setBusy(false);
        } else {
          ToastUtil.showToast("Car does not exists");
        }
      });
    }
    setBusy(false);
  }

  void clearController() {
    selectedCategory = 'Suzuki';
    titleController.text = modelController.text =
        colorController.text = registrationNoController.text = "";
    setBusy(false);
  }
}
