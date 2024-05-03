import 'Button_Category.dart';

class User {
  String name;
  String username;
  Map<String, ButtonCategory> buttons;

  User({
    required this.name,
    required this.username,
    required this.buttons,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      username: json['username'] as String,
      buttons: (json['buttons'] as Map<String, dynamic>).map((key, value) =>
          MapEntry(
              key, ButtonCategory.fromJson(value as Map<String, dynamic>))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'buttons': buttons.map((key, value) => MapEntry(key, value.toJson()))
    };
  }
}
