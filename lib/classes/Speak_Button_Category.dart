import 'package:cloud_firestore/cloud_firestore.dart';

class SpeakButtonCategory {
  final int categoryId;
  final String buttonCategory;

  const SpeakButtonCategory(
      {required this.categoryId, required this.buttonCategory});

  factory SpeakButtonCategory.fromDocument(DocumentSnapshot doc) {
    return SpeakButtonCategory(
        categoryId: doc.id as int,
        buttonCategory: doc['buttonCategory'] as String);
  }
}
