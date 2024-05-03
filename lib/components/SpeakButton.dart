import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/state/flutterTts_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SpeakButton extends ConsumerWidget {
  final int buttonID;
  final String buttonLabel;
  final String buttonSpeech;

  const SpeakButton({
    super.key,
    required this.buttonID,
    required this.buttonLabel,
    required this.buttonSpeech,
  });

  factory SpeakButton.fromDocument(DocumentSnapshot doc) {
    return SpeakButton(
        buttonID: doc.id as int,
        buttonLabel: doc['buttonLabel'] as String,
        buttonSpeech: doc['buttonSpeech'] as String);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ttsController = ref.watch(flutterTtsProvider);
    return GestureDetector(
      onLongPress: () {
        ttsController.speak(buttonSpeech);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 130,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Color(0xff300030),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 1.0,
                ),
              ),
              child: const Icon(
                Icons.handshake_sharp,
                size: 60,
                color: Colors.orange,
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    buttonSpeech, // Use buttonSpeech directly
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
            ),
          ],
        ),
      ),
    );
  }
}
