import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/components/SpeakButton.dart';
import 'package:firebase_flutter/controllers/userButtonDataController.dart';
import 'package:firebase_flutter/firebase_service/firebase_service.dart';
import 'package:firebase_flutter/screens/addcategory_page.dart';

import 'package:flutter/material.dart';

//Import from the Firebase Auth
import 'package:firebase_auth/firebase_auth.dart';
//Importing from the Screens Folder
import 'package:firebase_flutter/screens/addbutton_page.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

import 'package:firebase_flutter/controllers/flutter_tts_controller.dart';

import '../classes/Button.dart';
import '../components/CustomTextField.dart';
import 'editbutton_page.dart';

class DirectTextToSpeech extends GetxController {
  TextEditingController directTtsController = TextEditingController();
}

class MainDashboard extends StatefulWidget {
  // @override
  // void initState() {
  //   super.initState();
  //   // initTTS();
  // }

  // void initTTS() {
  //   _flutterTts.getVoices.then((data) {
  //     try {
  //       print("hey");
  //       List<Map> _voices = List<Map>.from(data);
  //       print(_voices);
  //     } catch (e) {
  //       print(e);
  //     }
  //   });
  // }

  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  final _editCategoryNameController = TextEditingController();
  final _confirmCategoryDeleteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //For Flutter TTS Controller
    final ttsController = Get.put(FlutterTtsController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "SpeakEase",
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Color(0xff800080),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff800080),
                              spreadRadius: 0.5,
                              blurRadius: 1,
                            )
                          ]),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Text(
                                "Welcome back, ",
                                style: TextStyle(color: Color(0xffFFF5FF), fontSize: 17),
                              ),
                              Text("Lois Griffin!",
                                  style: TextStyle(
                                      color: Color(0xffFFF5FF),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500))
                            ],
                          ),
                          const SizedBox(height: 30),
                          directTextToSpeechField(ttsController.flutterTts),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Buttons",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: const BorderRadius.all(Radius.circular(5))),
                              child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: Container(
                                          height: 100,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: const Color(0xffbe29ec),
                                                    border: Border.all(),
                                                    borderRadius:
                                                        const BorderRadius.all(Radius.circular(5))),
                                                padding: const EdgeInsets.symmetric(vertical: 10),
                                                width: 220,
                                                child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context).pop();
                                                      Navigator.push(context,
                                                          MaterialPageRoute(builder: (context) {
                                                        return AddCategoryPage();
                                                      }));
                                                    },
                                                    child: const Text(
                                                      "New Category",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 15, color: Colors.white),
                                                    )),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: const Color(0xffbe29ec),
                                                  border: Border.all(),
                                                  borderRadius:
                                                      const BorderRadius.all(Radius.circular(5)),
                                                ),
                                                padding: EdgeInsets.symmetric(vertical: 10),
                                                width: 220,
                                                child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context).pop();
                                                      Navigator.push(context,
                                                          MaterialPageRoute(builder: (context) {
                                                        return AddButtonPage();
                                                      }));
                                                    },
                                                    child: const Text(
                                                      "New Button",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 15, color: Colors.white),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Close'))
                                        ],
                                      ),
                                    );
                                  },
                                  child: const Icon(Icons.add)),
                            ),
                            const SizedBox(
                              width: 7.5,
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                        child: StreamBuilder<List<dynamic>>(
                      stream: FirebaseService.fetchUserButtons(
                          FirebaseService.firebaseAuth.currentUser!.uid),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        } else {
                          final buttonCategories = snapshot.data!;

                          return ListView.separated(
                            itemCount: buttonCategories.length,
                            separatorBuilder: (BuildContext context, int index) =>
                                const SizedBox(height: 10),
                            itemBuilder: (context, categoryIndex) {
                              final buttonCategory = buttonCategories[categoryIndex];
                              final categoryName = buttonCategory['categoryName'];
                              final categoryId = buttonCategory['categoryId'];
                              final categoryButtons = buttonCategory['categoryButtons'];
                              return Container(
                                height: categoryButtons.isEmpty ? 80 : 205,
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xffe6d0d0),
                                    width: 1.0,
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          categoryName,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                    border: Border.all(),
                                                    borderRadius: const BorderRadius.all(
                                                        Radius.circular(20))),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      _editCategoryNameController.clear();
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) => AlertDialog(
                                                          title: const Text("Edit Category Name"),
                                                          content: Container(
                                                            height: 80,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment.start,
                                                              children: [
                                                                Row(children: [
                                                                  const Text(
                                                                    "Current: ",
                                                                    style: TextStyle(
                                                                        fontSize: 16,
                                                                        letterSpacing: 0.5,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                  Text(categoryName,
                                                                      style: const TextStyle(
                                                                        fontSize: 16,
                                                                        letterSpacing: 0.5,
                                                                      )),
                                                                ]),
                                                                const SizedBox(
                                                                  height: 2,
                                                                ),
                                                                TextFormField(
                                                                  controller:
                                                                      _editCategoryNameController,
                                                                  decoration: InputDecoration(
                                                                    filled: true,
                                                                    fillColor:
                                                                        const Color(0xffe6e1e1),
                                                                    hintText:
                                                                        "Enter new category name",
                                                                    hintStyle: const TextStyle(
                                                                        color: Colors.grey,
                                                                        fontWeight:
                                                                            FontWeight.w300),
                                                                    border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(7),
                                                                    ),
                                                                    contentPadding:
                                                                        const EdgeInsets.all(10),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () async {
                                                                  String newCategoryName =
                                                                      _editCategoryNameController
                                                                          .text
                                                                          .trim();

                                                                  if (newCategoryName.isEmpty) {
                                                                    if (!Get.isSnackbarOpen) {
                                                                      Get.rawSnackbar(
                                                                          backgroundColor:
                                                                              Colors.red,
                                                                          duration: const Duration(
                                                                              milliseconds: 1500),
                                                                          messageText: const Text(
                                                                            "Please enter a new category name to continue.",
                                                                            style: TextStyle(
                                                                                color:
                                                                                    Colors.white),
                                                                          ));
                                                                    }
                                                                    return;
                                                                  } else if (newCategoryName ==
                                                                      categoryName) {
                                                                    if (!Get.isSnackbarOpen) {
                                                                      Get.rawSnackbar(
                                                                          backgroundColor:
                                                                              Colors.red,
                                                                          duration: const Duration(
                                                                              milliseconds: 1500),
                                                                          messageText: const Text(
                                                                            "New category name can't be the same as the old category name.",
                                                                            style: TextStyle(
                                                                                color:
                                                                                    Colors.white),
                                                                          ));
                                                                    }
                                                                    return;
                                                                  }

                                                                  try {
                                                                    await FirebaseService
                                                                        .editCategory(categoryId,
                                                                            newCategoryName);

                                                                    Navigator.of(context).pop();

                                                                    Get.rawSnackbar(
                                                                        backgroundColor:
                                                                            Colors.green,
                                                                        duration: const Duration(
                                                                            milliseconds: 1500),
                                                                        messageText: const Text(
                                                                          "Category name successfully edited.",
                                                                          style: TextStyle(
                                                                              color: Colors.white),
                                                                        ));
                                                                  } catch (e) {
                                                                    print(e);
                                                                    return;
                                                                  }
                                                                },
                                                                child: const Text('Save Changes')),
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                },
                                                                child: const Text('Close'))
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    child: const Icon(
                                                      Icons.edit,
                                                      size: 20,
                                                    )),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                    border: Border.all(),
                                                    borderRadius: const BorderRadius.all(
                                                        Radius.circular(20))),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      _confirmCategoryDeleteController.clear();
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) => AlertDialog(
                                                          title: Text("Delete " + categoryName),
                                                          content: Container(
                                                            height: 180,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment.start,
                                                              children: [
                                                                const Flexible(
                                                                  child: Text(
                                                                    "Deleting the category will also delete all of the buttons under it. Do you wish to continue?",
                                                                    softWrap: true,
                                                                    style: TextStyle(
                                                                        fontSize: 13,
                                                                        letterSpacing: 0.5,
                                                                        fontWeight: FontWeight.w500,
                                                                        color: Colors.red),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Flexible(
                                                                  child: Text(
                                                                    'Please enter "$categoryName" to continue.',
                                                                    softWrap: true,
                                                                    style: const TextStyle(
                                                                        fontSize: 13,
                                                                        letterSpacing: 0.5,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                TextFormField(
                                                                  controller:
                                                                      _confirmCategoryDeleteController,
                                                                  decoration: InputDecoration(
                                                                    filled: true,
                                                                    fillColor:
                                                                        const Color(0xffe6e1e1),
                                                                    hintText: 'Enter "' +
                                                                        categoryName +
                                                                        '"',
                                                                    hintStyle: const TextStyle(
                                                                        color: Colors.grey,
                                                                        fontWeight:
                                                                            FontWeight.w300),
                                                                    border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(7),
                                                                    ),
                                                                    contentPadding:
                                                                        const EdgeInsets.all(10),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () async {
                                                                  String confirmCategoryName =
                                                                      _confirmCategoryDeleteController
                                                                          .text
                                                                          .trim();

                                                                  if (confirmCategoryName.isEmpty) {
                                                                    if (!Get.isSnackbarOpen) {
                                                                      Get.rawSnackbar(
                                                                          backgroundColor:
                                                                              Colors.red,
                                                                          duration: const Duration(
                                                                              milliseconds: 1500),
                                                                          messageText: const Text(
                                                                            "Please enter the category name to continue.",
                                                                            style: TextStyle(
                                                                                color:
                                                                                    Colors.white),
                                                                          ));
                                                                    }
                                                                    return;
                                                                  } else if (confirmCategoryName !=
                                                                      categoryName) {
                                                                    if (!Get.isSnackbarOpen) {
                                                                      Get.rawSnackbar(
                                                                          backgroundColor:
                                                                              Colors.red,
                                                                          duration: const Duration(
                                                                              milliseconds: 1500),
                                                                          messageText: const Text(
                                                                            "Category name doesn't match. Please try again.",
                                                                            style: TextStyle(
                                                                                color:
                                                                                    Colors.white),
                                                                          ));
                                                                    }
                                                                    return;
                                                                  }

                                                                  try {
                                                                    await FirebaseService
                                                                        .deleteCategory(
                                                                      categoryId,
                                                                    );

                                                                    Navigator.of(context).pop();

                                                                    Get.rawSnackbar(
                                                                        backgroundColor:
                                                                            Colors.green,
                                                                        duration: const Duration(
                                                                            milliseconds: 1500),
                                                                        messageText: const Text(
                                                                          "Category is sucessfully deleted.",
                                                                          style: TextStyle(
                                                                              color: Colors.white),
                                                                        ));
                                                                  } catch (e) {
                                                                    print(e);
                                                                    return;
                                                                  }
                                                                },
                                                                child:
                                                                    const Text('Delete Category')),
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                },
                                                                child: const Text('Close'))
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    child: const Icon(
                                                      Icons.delete,
                                                      size: 20,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                        height: categoryButtons.isEmpty ? 30 : 155,
                                        child: categoryButtons.isEmpty
                                            ? const Text(
                                                "Add new buttons for this category.",
                                                style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                    color: const Color(0xffbe29ec)),
                                              )
                                            : ListView.separated(
                                                scrollDirection: Axis.horizontal,
                                                separatorBuilder:
                                                    (BuildContext context, int index) =>
                                                        const SizedBox(width: 5),
                                                itemCount: categoryButtons.length,
                                                itemBuilder: (context, buttonIndex) {
                                                  Button button =
                                                      Button.fromJson(categoryButtons[buttonIndex]);
                                                  return GestureDetector(
                                                    onDoubleTap: () {
                                                      Navigator.push(context,
                                                          MaterialPageRoute(builder: (context) {
                                                        return EditButtonPage(
                                                          button: button,
                                                          categoryId: categoryId,
                                                        );
                                                      }));
                                                    },
                                                    child: SpeakButton(
                                                        buttonId: categoryButtons[buttonIndex]
                                                            ['buttonId'],
                                                        buttonName: categoryButtons[buttonIndex]
                                                            ['buttonName'],
                                                        language: categoryButtons[buttonIndex]
                                                            ['language'],
                                                        speechText: categoryButtons[buttonIndex]
                                                            ['speechText']),
                                                  );
                                                })
                                        // ,
                                        )
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    )),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xff152238),
        child: ListView(
          children: [
            DrawerHeader(
                child: Row(
              children: [
                Column(
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
                        Icons.account_circle_sharp,
                        size: 60,
                        color: Colors.orange,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder(
                        stream: FirebaseService.fetchName(
                            FirebaseService.firebaseAuth.currentUser!.uid),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Text(
                              "Fetching name....",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                            );
                          } else {
                            return Text(
                              snapshot.data! as String,
                              style:
                                  const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                            );
                          }
                        }),
                    StreamBuilder(
                        stream: FirebaseService.fetchUserName(
                            FirebaseService.firebaseAuth.currentUser!.uid),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Text(
                              "Fetching username....",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                            );
                          } else {
                            return Text(
                              snapshot.data! as String,
                              style: const TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
                            );
                          }
                        }),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.do_not_disturb_on_total_silence_sharp,
                          size: 12,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        StreamBuilder(
                            stream: FirebaseService.fetchUserCategoryCount(
                                FirebaseService.firebaseAuth.currentUser!.uid),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Text(
                                  "Fetching counts....",
                                  style:
                                      TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                                );
                              } else {
                                return Text(
                                  "${snapshot.data!.toString()} ${snapshot.data! > 1 ? "categories" : "category"}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                );
                              }
                            })
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.do_not_disturb_on_total_silence_sharp,
                          size: 12,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        StreamBuilder(
                            stream: FirebaseService.fetchUserButtonCount(
                                FirebaseService.firebaseAuth.currentUser!.uid),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Text(
                                  "Fetching counts....",
                                  style:
                                      TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                                );
                              } else {
                                return Text(
                                  "${snapshot.data!.toString()} ${snapshot.data! > 1 ? "buttons" : "button"}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                );
                              }
                            })
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.do_not_disturb_on_total_silence_sharp,
                          size: 12,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 155,
                          child: Flexible(
                              child: StreamBuilder(
                                  stream: FirebaseService.fetchRegistrationDate(
                                      FirebaseService.firebaseAuth.currentUser!.uid),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return const Text(
                                        "Fetching date....",
                                        style: TextStyle(
                                            color: Colors.white, fontWeight: FontWeight.w500),
                                      );
                                    } else {
                                      return Text(
                                        "User since ${snapshot.data!}",
                                        softWrap: true,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13),
                                      );
                                    }
                                  })),
                        )
                      ],
                    ),
                  ],
                )
              ],
            )),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                "Settings",
                style: TextStyle(color: Colors.white),
              ),
              iconColor: Color(0xFFEDECFE),
            ),
            const ListTile(
              leading: Icon(Icons.question_mark),
              title: Text(
                "Help",
                style: TextStyle(color: Colors.white),
              ),
              iconColor: Color(0xFFEDECFE),
            ),
            const ListTile(
              leading: Icon(Icons.keyboard),
              title: Text(
                "Meet the Developers",
                style: TextStyle(color: Colors.white),
              ),
              iconColor: Color(0xFFEDECFE),
            ),
            GestureDetector(
              onTap: () async {
                await FirebaseService.signOut();
              },
              child: const ListTile(
                leading: Icon(Icons.logout),
                title: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
                iconColor: Color(0xFFEDECFE),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextField directTextToSpeechField(FlutterTts ttsController) {
    //For DirectTextToSpeechController
    final directTextToSpeechController = Get.put(DirectTextToSpeech());

    return TextField(
      controller: directTextToSpeechController.directTtsController,
      decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xffFFF5FF),
          hintText: "Got something to share?",
          hintStyle: const TextStyle(color: Color(0xffADA0A0), fontSize: 15),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(width: 1, color: Color(0xffFFF5FF))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: const BorderSide(width: 1, color: Color(0xffFFF5FF))),
          contentPadding: const EdgeInsets.all(10),
          suffixIcon: IconButton(
            icon: const Icon(Icons.speaker_phone),
            color: const Color(0xff800080),
            onPressed: () {
              ttsController.speak(directTextToSpeechController.directTtsController.text.trim());
            },
          )),
    );
  }
}
