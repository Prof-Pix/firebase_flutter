import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/controllers/flutter_tts_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpeakButton extends StatelessWidget {
  final String buttonId;
  final String buttonName;
  final String language;
  final String speechText;

  const SpeakButton(
      {super.key,
      required this.buttonId,
      required this.buttonName,
      required this.language,
      required this.speechText});

  factory SpeakButton.fromJson(Map<String, dynamic> json) {
    return SpeakButton(
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

  @override
  Widget build(BuildContext context) {
    final ttsController = Get.find<FlutterTtsController>();
    return GestureDetector(
      onLongPress: () {
        ttsController.flutterTts.setLanguage(language);
        ttsController.flutterTts.speak(speechText);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 110,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xff300030),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 70,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 1.0,
                ),
              ),
              child: const Icon(
                Icons.speaker,
                size: 60,
                color: Colors.orange,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  buttonName, // Use buttonSpeech directly
                  style: const TextStyle(
                    color: Colors.white,
                    letterSpacing: 0.5,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
