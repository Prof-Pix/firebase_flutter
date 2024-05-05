// import 'package:firebase_flutter/classes/Button_Category.dart';
// import 'package:firebase_flutter/firebase_service/firebase_service.dart';
// import 'package:get/get.dart';
//
// import '../classes/Button.dart';
//
// class UserButtonDataController extends GetxController {
//   Rx<List<dynamic>> buttonData = Rx<List<dynamic>>([]);
//   bool isLoading = false;
//   bool hasError = false;
//   String errorT = "";
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchUserDataFromFirebase();
//   }
//
//   Future<void> fetchUserDataFromFirebase() async {
//     isLoading = true;
//     update();
//     try {
//       buttonData.value = await FirebaseService.fetchUserButtonsData();
//     } catch (error) {
//       hasError = true;
//       print("erorrrrr");
//       errorT = error.toString();
//     } finally {
//       isLoading = false;
//       update();
//     }
//   }
//
//   Future<List<ButtonCategory>> fetchButtonCategories() async {
//     List<ButtonCategory> buttonCategories = [];
//     try {
//       for (dynamic buttonJson in buttonData.value) {
//         ButtonCategory buttonCategory;
//         buttonCategory = ButtonCategory.fromJson(buttonJson);
//         buttonCategories.add(buttonCategory);
//       }
//       return buttonCategories;
//     } catch (error) {
//       print(error);
//       return [];
//     }
//   }
//
//   Future<void> addNewButton(Button newButton, String categoryId) async {
//     update();
//     try {
//       await FirebaseService.addNewButton(newButton, categoryId);
//     } catch (e) {
//       print(e);
//     } finally {
//       update();
//     }
//   }
//
//   Future<void> addNewCategory(ButtonCategory buttonCategory) async {
//     update();
//     try {
//       await FirebaseService.addNewCategory(buttonCategory);
//     } catch (e) {
//       print(e);
//     } finally {
//       update();
//     }
//   }
// }
