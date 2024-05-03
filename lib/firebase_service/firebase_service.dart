import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static final _firestore = FirebaseFirestore.instance;
  static final _firebaseAuth = FirebaseAuth.instance;

  //For signing in
  static Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credential") {
        return "InvalidCredential";
      } else {
        print(e.code);
        return "UnknownError";
      }
    } catch (e) {
      print(e);
      return "UnknownError";
    }
  }

  //For newly created accounts
  //Setting up a template structure for the account database in Firebase FireStore
}
