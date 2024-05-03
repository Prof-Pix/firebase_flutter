import 'package:firebase_flutter/components/SpeakButton.dart';

import 'package:flutter/material.dart';

//Import from the Firebase Auth
import 'package:firebase_auth/firebase_auth.dart';
//Importing from the Screens Folder
import 'package:firebase_flutter/screens/addbutton_page.dart';
//Import for the State Management
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../firebase_service/firestore_provider.dart';
import '../state/flutterTts_provider.dart';

class MainDashboard extends ConsumerStatefulWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  MainDashboardState createState() => MainDashboardState();
}

class MainDashboardState extends ConsumerState<MainDashboard> {
  @override
  void initState() {
    super.initState();
    // initTTS();
  }

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

  final TextEditingController _directTxtToSpeechController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ttsController = ref.watch(flutterTtsProvider);
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
                height: 40,
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
                          directTextToSpeechField(ttsController),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return AddButtonPage(
                                        firestore: ref.watch(firestoreProvider),
                                      );
                                    }));
                                  },
                                  child: const Icon(Icons.add)),
                            ),
                            const SizedBox(
                              width: 7.5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: const BorderRadius.all(Radius.circular(5))),
                              child: const Icon(Icons.description_rounded),
                            ),
                            const SizedBox(
                              width: 7.5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: const BorderRadius.all(Radius.circular(5))),
                              child: const Icon(Icons.delete),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SpeakButton(
                        buttonID: 12313, buttonLabel: "Thank you", buttonSpeech: "Henlo"),
                    // Expanded(
                    //   child: StreamBuilder<List<SpeakButtonTemplate>>(
                    //     stream: ref.watch(speechButtonsProvider),
                    //     builder: (context, snapshot) {
                    //       if (snapshot.hasData) {
                    //         return ListView.separated(
                    //           itemCount: snapshot.data!.docs.length,
                    //           separatorBuilder:
                    //               (BuildContext context, int index) =>
                    //                   const SizedBox(height: 10),
                    //           itemBuilder: (context, index) {
                    //             return Container(
                    //               height: 220,
                    //               padding: const EdgeInsets.all(10),
                    //               decoration: BoxDecoration(
                    //                 border: Border.all(
                    //                   color: const Color(0xffe6d0d0),
                    //                   width: 1.0,
                    //                 ),
                    //                 borderRadius: const BorderRadius.all(
                    //                     Radius.circular(5)),
                    //               ),
                    //               child: Column(
                    //                 children: [
                    //                   Row(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.spaceBetween,
                    //                     children: [
                    //                       Text(
                    //                         snapshot.data!.docs[index]
                    //                             .data()['categoryName'],
                    //                         style:
                    //                             const TextStyle(fontSize: 18),
                    //                       ),
                    //                       const Icon(
                    //                           Icons.keyboard_arrow_up_rounded),
                    //                     ],
                    //                   ), // Corrected missing parenthesis
                    //                 ],
                    //               ),
                    //             );
                    //           },
                    //         );
                    //       } else if (snapshot.hasError) {
                    //         return const Text(
                    //             "error"); // Use const for simple widgets
                    //       } else {
                    //         return const CircularProgressIndicator(); // Use const
                    //       }
                    //     },
                    //   ),
                    // ),
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lois Griffin",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
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
                        Text(
                          "User since 2014",
                          style: TextStyle(
                              fontSize: 15, color: Colors.white, fontWeight: FontWeight.w100),
                        )
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
                        Text("24 buttons",
                            style: TextStyle(
                                fontSize: 15, color: Colors.white, fontWeight: FontWeight.w100))
                      ],
                    ),
                  ],
                )
              ],
            )),
            const ListTile(
              leading: Icon(Icons.account_circle_sharp),
              title: Text(
                "Profile",
                style: TextStyle(color: Colors.white),
              ),
              iconColor: Color(0xFFEDECFE),
            ),
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
              onTap: () {
                FirebaseAuth.instance.signOut();
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
    return TextField(
      controller: _directTxtToSpeechController,
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
              ttsController.speak(_directTxtToSpeechController.text.trim());
            },
          )),
    );
  }
}
