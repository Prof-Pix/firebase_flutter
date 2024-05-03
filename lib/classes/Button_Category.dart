// ignore_for_file: unnecessary_getters_setters

import 'Button.dart';

class ButtonCategory {
  String categoryId;
  String categoryName;
  List<Button> buttons;

  ButtonCategory(
      {required this.categoryId,
      required this.categoryName,
      required this.buttons});

  factory ButtonCategory.fromJson(Map<String, dynamic> json) {
    return ButtonCategory(
        categoryId: json['categoryId'] as String,
        categoryName: json['categoryName'],
        buttons: (json['buttons'] as List<Button>).toList());
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'buttons': buttons
    };
  }
}
