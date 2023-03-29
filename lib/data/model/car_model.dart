class CarModel {
  String? category;
  String? color;
  String? model;
  String? registrationNo;
  String? name;

  CarModel(
      {required this.category,
      required this.name,
      required this.color,
      required this.model,
      required this.registrationNo});

  CarModel.fromJson(Map<String, dynamic> json) {
    category = json['catagory'];
    color = json['color'];
    model = json['model'];
    registrationNo = json['reg_no'];
    name = json['name'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['catagory'] = category;
    json['color'] = color;
    json['model'] = model;
    json['reg_no'] = registrationNo;
    json['name'] = name;
    return json;
  }
}
