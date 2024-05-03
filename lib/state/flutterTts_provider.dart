import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';

final flutterTtsProvider =
    StateNotifierProvider<FlutterTtsController, FlutterTts>(
        (ref) => FlutterTtsController());

class FlutterTtsController extends StateNotifier<FlutterTts> {
  FlutterTtsController() : super(FlutterTts());
}
