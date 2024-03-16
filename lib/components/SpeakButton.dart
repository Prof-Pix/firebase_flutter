import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

//Text Field Component

//Password Field Component

class SpeakButton extends StatefulWidget {
  final FlutterTts _flutterTts;
  final String _speakText;

  const SpeakButton(
      {super.key, required FlutterTts flutterTts, required String speakText})
      : _flutterTts = flutterTts,
        _speakText = speakText;

  @override
  State<SpeakButton> createState() => _SpeakButtonState();
}

class _SpeakButtonState extends State<SpeakButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        widget._flutterTts.speak(widget._speakText);
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
                    widget._speakText,
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
