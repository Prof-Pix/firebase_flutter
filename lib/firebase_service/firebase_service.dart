import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_flutter/classes/Button_Category.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../classes/Button.dart';

class FirebaseService {
  static final firestore = FirebaseFirestore.instance;
  static final firebaseAuth = FirebaseAuth.instance;
  static final userRef = firestore.collection('users');

  //For signing in
  static Future<String?> signInWithEmailAndPassword(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
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

  //For signing up
  static Future<void> createUserWithEmailAndPassword(
      String email, String password, String name, String username) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
    }

    try {
      final userDocRef = userRef.doc(FirebaseService.firebaseAuth.currentUser!.uid);
      userDocRef.update({'name': name});

      print(name);
    } catch (e) {
      print(e);
    }

    try {
      final userDocRef = userRef.doc(FirebaseService.firebaseAuth.currentUser!.uid);
      userDocRef.update({'username': username});

      print(name);
    } catch (e) {
      print(e);
    }

    try {
      final userDocRef = userRef.doc(FirebaseService.firebaseAuth.currentUser!.uid);
      DateTime now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);

      String formattedDate = DateFormat('MMM dd, yyyy').format(today);
      userDocRef.update({'registrationDate': formattedDate});

      print(name);
    } catch (e) {
      print(e);
    }
  }

  static Future<void> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print('errorrrrrr');
      if (e.code == 'user-not-found') {
        Get.rawSnackbar(messageText: const Text("Email isn't registered to the application."));
      } else if (e.code == 'invalid-email') {
        Get.rawSnackbar(messageText: const Text("Invalid Email. Please try again,"));
      }
    }
  }

  //For signing out
  static Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
      Get.rawSnackbar(messageText: const Text("Logout Successfully."));
    } catch (e) {
      print(e);
      Get.rawSnackbar(messageText: const Text("An error occurred. Please try again later"));
    }
  }

  //For fetching registration date
  static Stream<dynamic> fetchRegistrationDate(String userId) {
    final docRef = userRef.doc(userId);
    return docRef.snapshots().map((docSnapshot) {
      if (docSnapshot.exists) {
        return docSnapshot.data()!['registrationDate'];
      } else {
        return [];
      }
    });
  }

  //For fetching name
  static Stream<dynamic> fetchName(String userId) {
    final docRef = userRef.doc(userId);
    return docRef.snapshots().map((docSnapshot) {
      if (docSnapshot.exists) {
        return docSnapshot.data()!['name'];
      } else {
        return [];
      }
    });
  }

  static Stream<dynamic> fetchUserCategoryCount(String userId) {
    final docRef = userRef.doc(userId);
    return docRef.snapshots().map((docSnapshot) {
      if (docSnapshot.exists) {
        return docSnapshot.data()!['buttonCategories'].length;
      } else {
        return [];
      }
    });
  }

  static Stream<dynamic> fetchUserButtonCount(String userId) {
    final docRef = userRef.doc(userId);
    return docRef.snapshots().map((docSnapshot) {
      if (docSnapshot.exists) {
        int totalCount = 0;
        final buttonCategories = docSnapshot.data()!['buttonCategories'];

        for (int i = 0; i < buttonCategories.length; i++) {
          if (buttonCategories[i]['categoryButtons'] != null) {
            totalCount += buttonCategories[i]['categoryButtons'].length! as int;
          }
        }
        return totalCount;
      } else {
        return [];
      }
    });
  }

  //For fetching username
  static Stream<dynamic> fetchUserName(String userId) {
    final docRef = userRef.doc(userId);
    return docRef.snapshots().map((docSnapshot) {
      if (docSnapshot.exists) {
        return docSnapshot.data()!['username'];
      } else {
        return [];
      }
    });
  }

  //For the StreamBuilder in MainDashboard (Buttons, Category)
  static Stream<List<dynamic>> fetchUserButtons(String userId) {
    final docRef = userRef.doc(userId);
    return docRef.snapshots().map((docSnapshot) {
      if (docSnapshot.exists) {
        return docSnapshot.data()!['buttonCategories'];
      } else {
        return [];
      }
    });
  }

  static Future<void> addNewButton(Button newButton, String categoryId) async {
    //Fetching the already existing data inside the firebase
    final docSnapshot = await userRef.doc(FirebaseService.firebaseAuth.currentUser!.uid).get();

    if (docSnapshot.exists) {
      final buttonCategories = docSnapshot.get('buttonCategories');

      //Find the correct category
      final categoryIndex = buttonCategories.indexWhere(// Find the index
          (category) => category['categoryId'] == categoryId);

      //Add the new button to the category
      if (categoryIndex != -1) {
        buttonCategories[categoryIndex]['categoryButtons'].add({
          // Update the original array
          ...newButton.toJson()
        });
      }

      //Update Firestore
      final user = firebaseAuth.currentUser;
      if (user != null) {
        final userId = user.uid;
        final userDocRef = userRef.doc(userId);
        await userDocRef.update({'buttonCategories': buttonCategories});
      }
    }
  }

  static Future<void> addNewCategory(ButtonCategory buttonCategory) async {
    //Fetching the already existing data inside the firebase
    final docSnapshot = await userRef.doc(FirebaseService.firebaseAuth.currentUser!.uid).get();

    if (docSnapshot.exists) {
      final buttonCategories = docSnapshot.get('buttonCategories');

      //Add the new category
      buttonCategories.add({
        // Update the original array
        ...buttonCategory.toJson()
      });

      //Update Firestore
      final user = firebaseAuth.currentUser;
      if (user != null) {
        final userId = user.uid;
        final userDocRef = userRef.doc(userId);
        await userDocRef.update({'buttonCategories': buttonCategories});
      }
    }
  }

  static Future<void> editCategory(String categoryId, String newCategoryName) async {
    //Fetching the already existing data inside the firebase
    final docSnapshot = await userRef.doc(FirebaseService.firebaseAuth.currentUser!.uid).get();

    if (docSnapshot.exists) {
      final buttonCategories = docSnapshot.get('buttonCategories');

      final categoryIndex =
          buttonCategories.indexWhere((category) => category['categoryId'] == categoryId);

      if (categoryIndex != -1) {
        // Modify the categoryName
        buttonCategories[categoryIndex]['categoryName'] = newCategoryName;

        // Update Firestore
        final userDocRef = userRef.doc(FirebaseService.firebaseAuth.currentUser!.uid);
        await userDocRef.update({'buttonCategories': buttonCategories});
      }
    }

    // Find the category
  }

  static Future<void> deleteCategory(String categoryId) async {
    //Fetching the already existing data inside the firebase
    final docSnapshot = await userRef.doc(FirebaseService.firebaseAuth.currentUser!.uid).get();

    if (docSnapshot.exists) {
      final buttonCategories = docSnapshot.get('buttonCategories');

      // Remove the category (using removeWhere for flexibility)
      buttonCategories.removeWhere((category) => category['categoryId'] == categoryId);

      // Update Firestore
      final userDocRef = userRef.doc(FirebaseService.firebaseAuth.currentUser!.uid);
      await userDocRef.update({'buttonCategories': buttonCategories});
    }
  }

  static Future<void> deleteButton(String categoryId, String buttonId) async {
    //Fetching the already existing data inside the firebase
    final docSnapshot = await userRef.doc(FirebaseService.firebaseAuth.currentUser!.uid).get();

    if (docSnapshot.exists) {
      final buttonCategories = docSnapshot.get('buttonCategories');

      final categoryIndex =
          buttonCategories.indexWhere((category) => category['categoryId'] == categoryId);

      if (categoryIndex != -1) {
        // Find the button
        final buttonIndex = buttonCategories[categoryIndex]['categoryButtons']
            .indexWhere((button) => button['buttonId'] == buttonId);

        if (buttonIndex != -1) {
          // Remove the button
          buttonCategories[categoryIndex]['categoryButtons'].removeAt(buttonIndex);

          // Update Firestore
          final userDocRef = userRef.doc(FirebaseService.firebaseAuth.currentUser!.uid);
          await userDocRef.update({'buttonCategories': buttonCategories});
        } else {
          // Handle case: Button not found
        }
      }
    }
  }

  static Future<void> editButton(String categoryId, Button editedButtonData) async {
    //Fetching the already existing data inside the firebase
    final docSnapshot = await userRef.doc(FirebaseService.firebaseAuth.currentUser!.uid).get();

    if (docSnapshot.exists) {
      final buttonCategories = docSnapshot.get('buttonCategories');

      final categoryIndex =
          buttonCategories.indexWhere((category) => category['categoryId'] == categoryId);

      if (categoryIndex != -1) {
        // Find the button
        final buttonIndex = buttonCategories[categoryIndex]['categoryButtons']
            .indexWhere((button) => button['buttonId'] == editedButtonData.buttonId);

        if (buttonIndex != -1) {
          // Remove the button
          buttonCategories[categoryIndex]['categoryButtons'][buttonIndex] =
              editedButtonData.toJson();

          // Update Firestore
          final userDocRef = userRef.doc(FirebaseService.firebaseAuth.currentUser!.uid);
          await userDocRef.update({'buttonCategories': buttonCategories});
        }
      }
    }
  }
}
