// ignore_for_file: unnecessary_getters_setters

class Button {
  String buttonId;
  String buttonName;
  String language;
  String speechText;

  Button(
      {required this.buttonId,
      required this.buttonName,
      required this.language,
      required this.speechText});

  factory Button.fromJson(Map<String, dynamic> json) {
    return Button(
        buttonId: json['buttonId'] as String,
        buttonName: json['buttonName'] as String,
        language: json['language'] as String,
        speechText: json['speechText'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'buttonId': buttonId,
      'buttonName': buttonName,
      'language': language,
      'speechText': speechText
    };
  }
}
