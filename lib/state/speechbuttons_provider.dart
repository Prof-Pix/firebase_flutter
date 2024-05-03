import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/SpeakButton.dart';

final firestore = FirebaseFirestore.instance;

final speechButtonsProvider = StreamProvider<List<SpeakButton>>((ref) {
  return firestore
      .collection("speech_buttons")
      .doc("speech_buttons_caategories")
      .collection("bc_chats")
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((snapshotDoc) => SpeakButton.fromDocument(snapshotDoc))
          .toList());
});
