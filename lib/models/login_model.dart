import 'dart:convert';

class LoginModel {
  String username = '', password = '';

  LoginModel({
    required this.username,
    required this.password,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    username = json['username'] ?? '';
    password = json['password'] ?? '';
  }

  static Map<String, dynamic> toMap(LoginModel user) => <String, dynamic>{
        'username': user.username,
        'password': user.password,
      };

  static String serialize(LoginModel model) =>
      json.encode(LoginModel.toMap(model));

  static LoginModel deserialize(String json) =>
      LoginModel.fromJson(jsonDecode(json));
}
