import 'package:firebase_flutter/classes/Button_Category.dart';
import 'package:firebase_flutter/firebase_service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/CustomTextField.dart';
import '../controllers/userButtonDataController.dart';
import 'package:uuid/uuid.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final _categoryTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add Button Category"),
        centerTitle: true,
        elevation: 1,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              CustomTextField(
                  labelText: "Button Category",
                  hintText: "Enter category",
                  controller: _categoryTitleController,
                  prefixIcon: Icons.account_circle_sharp),
              const SizedBox(
                height: 40,
              ),
              TextButton(
                onPressed: () async {
                  var uuid = Uuid();
                  String categoryName = _categoryTitleController.text.trim();
                  ButtonCategory buttonCategory = ButtonCategory(
                      categoryId: uuid.v4(), categoryName: categoryName, buttons: []);

                  try {
                    await FirebaseService.addNewCategory(buttonCategory);
                    Navigator.of(context).pop();
                  } catch (e) {
                    print(e);
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xffbe29ec),
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                ),
                child: const Text("Add Button Category",
                    style: TextStyle(
                        color: Color(0xffffffff), fontSize: 15.7, fontWeight: FontWeight.w700)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
