class UserModel {
  late String id;
  String? name;
  String? email;
  String? phoneno;
  String? password;

  UserModel({
    required this.id,
    this.name,
    this.email,
    this.phoneno,
    this.password,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneno = json['phoneno'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['username'] = email;
    data['phoneno'] = phoneno;
    data['password'] = password;
    return data;
  }
}
