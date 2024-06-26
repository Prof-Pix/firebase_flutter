import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/classes/Button.dart';
import 'package:firebase_flutter/classes/Button_Category.dart';
import 'package:firebase_flutter/components/CustomTextField.dart';
import 'package:firebase_flutter/components/CustomTextFieldLarge.dart';
import 'package:firebase_flutter/controllers/flutter_tts_controller.dart';
import 'package:firebase_flutter/firebase_service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import '../controllers/userButtonDataController.dart';

class AddButtonPage extends StatefulWidget {
  const AddButtonPage({super.key});

  @override
  State<AddButtonPage> createState() => _AddButtonPageState();
}

class _AddButtonPageState extends State<AddButtonPage> {
  final _formKey = GlobalKey<FormState>();

  final _buttonTitleController = TextEditingController();
  final _buttonSpeechController = TextEditingController();

  String? _buttonCategoryDefaultValue;
  String? _languageDefaultValue;

  @override
  Widget build(BuildContext context) {
    final ttsController = Get.put(FlutterTtsController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add Button"),
        centerTitle: true,
        elevation: 1,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Container(
              //       width: 80,
              //       height: 80,
              //       decoration: BoxDecoration(
              //         shape: BoxShape.circle,
              //         border: Border.all(
              //           color: Colors.black,
              //           width: 1.0,
              //         ),
              //       ),
              //       child: const Icon(
              //         Icons.speaker,
              //         size: 60,
              //         color: Colors.orange,
              //       ),
              //     ),
              //     TextButton(onPressed: () {}, child: const Text("Choose icon"))
              //   ],
              // ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Select Category",
                        style: TextStyle(fontSize: 16, letterSpacing: 0.5),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: const BorderRadius.all(Radius.circular(10))),
                        width: 280,
                        child: DropdownButtonHideUnderline(
                            child: StreamBuilder<List<dynamic>>(
                          stream: FirebaseService.fetchUserButtons(
                              FirebaseService.firebaseAuth.currentUser!.uid),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Text("Fetching categories...");
                            } else {
                              final buttonCategories = snapshot.data!;

                              List<ButtonCategory> categories = [];
                              for (dynamic buttonCategory in buttonCategories) {
                                final categoryName = buttonCategory['categoryName'];
                                final categoryId = buttonCategory['categoryId'];
                                final categoryButtons = buttonCategory['categoryButtons'];

                                ButtonCategory category = ButtonCategory.fromJson(buttonCategory);
                                categories.add(category);
                              }

                              return DropdownButton<String>(
                                value: _buttonCategoryDefaultValue,
                                elevation: 3,
                                isExpanded: true,
                                hint: const Text("Select a button category"),
                                items: [
                                  ...categories.map<DropdownMenuItem<String>>(
                                      (ButtonCategory buttonCategory) {
                                    return DropdownMenuItem<String>(
                                      value: buttonCategory.categoryId,
                                      child: Text(buttonCategory.categoryName!),
                                    );
                                  }).toList(),
                                ],
                                onChanged: (String? value) {
                                  setState(() {
                                    _buttonCategoryDefaultValue =
                                        value ?? _buttonCategoryDefaultValue;
                                  });
                                },
                              );
                            }
                          },
                        )),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              CustomTextField(
                  labelText: "Button Name",
                  hintText: "Enter button name",
                  controller: _buttonTitleController,
                  prefixIcon: Icons.account_circle_sharp),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffbe29ec),
                        border: Border.all(),
                        borderRadius: const BorderRadius.all(Radius.circular(5))),
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    width: 35,
                    child: GestureDetector(
                        onTap: () {
                          String speechText = _buttonSpeechController.text.trim();

                          if (_languageDefaultValue!.isEmpty || speechText.isEmpty) {
                            Get.rawSnackbar(
                                backgroundColor: Colors.green,
                                duration: const Duration(milliseconds: 1500),
                                messageText: const Text(
                                  "Please enter a language and speech to use the voice preview.",
                                  style: TextStyle(color: Colors.white),
                                ));
                            return;
                          }

                          String language = _languageDefaultValue!;
                          ttsController.flutterTts.setLanguage(language);
                          ttsController.flutterTts.speak(speechText);
                        },
                        child: const Icon(
                          Icons.speaker_phone,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
              CustomTextFieldLarge(
                labelText: "Button Speech",
                hintText: "Enter button speech to speak",
                controller: _buttonSpeechController,
                horizontalHeight: 10.0,
                verticalHeight: 10.0,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Select Language",
                        style: TextStyle(fontSize: 16, letterSpacing: 0.5),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: const BorderRadius.all(Radius.circular(10))),
                        width: 280,
                        child: DropdownButtonHideUnderline(
                          child: FutureBuilder<dynamic>(
                              future: ttsController.flutterTts.getLanguages,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return DropdownButton<dynamic>(
                                    value: _languageDefaultValue,
                                    elevation: 3,
                                    isExpanded: true,
                                    hint: const Text("Select a language"),
                                    items: [
                                      ...snapshot.data!
                                          .map<DropdownMenuItem<dynamic>>((dynamic buttonCategory) {
                                        return DropdownMenuItem<dynamic>(
                                          value: buttonCategory,
                                          child: Text(buttonCategory),
                                        );
                                      }).toList(),
                                    ],
                                    onChanged: (dynamic value) {
                                      setState(() {
                                        _languageDefaultValue = value ?? _languageDefaultValue;
                                      });
                                    },
                                  );
                                } else {
                                  return const Text("Fetching Languages...");
                                }
                              }),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xffbe29ec),
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                  ),
                  onPressed: () async {
                    // Example Output: 2023-05-30

                    if (!_formKey.currentState!.validate()) {
                      if (!Get.isSnackbarOpen) {
                        Get.rawSnackbar(
                            messageText: const Text(
                              "Please check all the required fields.",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: const Color(0xffff0000),
                            duration: const Duration(seconds: 2));
                      }
                      return;
                    }
                    var uuid = Uuid();
                    String buttonId = uuid.v4();
                    String buttonName = _buttonTitleController.text.trim();
                    String speechText = _buttonSpeechController.text.trim();
                    String language = _languageDefaultValue!;

                    Button newButton = Button(
                        buttonId: buttonId,
                        buttonName: buttonName,
                        language: language,
                        speechText: speechText);

                    try {
                      await FirebaseService.addNewButton(newButton, _buttonCategoryDefaultValue!);
                      Navigator.pop(context);
                      Get.rawSnackbar(
                          backgroundColor: Colors.green,
                          duration: const Duration(milliseconds: 1500),
                          messageText: const Text(
                            "Button successfully added.",
                            style: TextStyle(color: Colors.white),
                          ));
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: const Text(
                    "Add Speech Button",
                    style: TextStyle(
                        color: Color(0xffffffff), fontSize: 15.7, fontWeight: FontWeight.w700),
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
