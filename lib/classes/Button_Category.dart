// ignore_for_file: unnecessary_getters_setters

import 'Button.dart';

class ButtonCategory {
  String? categoryId;
  String? categoryName;
  List<Button>? buttons;

  ButtonCategory({required this.categoryId, required this.categoryName, required this.buttons});

  ButtonCategory.nameId({required this.categoryId, required this.categoryName});

  factory ButtonCategory.fromJson(Map<String, dynamic> json) {
    return ButtonCategory(
        categoryId: json['categoryId'] as String,
        categoryName: json['categoryName'] as String,
        buttons: (json['categoryButtons'] as List) // Cast the inner list.
            .map((buttonJson) => Button.fromJson(buttonJson)) // Map each item.
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {'categoryId': categoryId, 'categoryName': categoryName, 'categoryButtons': buttons};
  }
}
