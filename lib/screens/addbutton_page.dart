import 'package:firebase_flutter/components/CustomTextField.dart';
import 'package:firebase_flutter/components/CustomTextFieldLarge.dart';
import 'package:flutter/material.dart';

class AddButtonPage extends StatefulWidget {
  const AddButtonPage({super.key});

  @override
  State<AddButtonPage> createState() => _AddButtonPageState();
}

class _AddButtonPageState extends State<AddButtonPage> {
  final _formKey = GlobalKey<FormState>();

  //Sample List of Category Options
  final List<String> _buttonCategories = ['Emotions', "Chats", "Conversations"];

  final _buttonTitleController = TextEditingController();
  final _buttonSpeechController = TextEditingController();

  String? _buttonCategoryDefaultValue;

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.all(40),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  ),
                  TextButton(onPressed: () {}, child: const Text("Choose icon"))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  labelText: "Button Title",
                  hintText: "Enter button title",
                  controller: _buttonTitleController,
                  prefixIcon: Icons.account_circle_sharp),
              const SizedBox(height: 20),
              CustomTextFieldLarge(
                labelText: "Button Speech",
                hintText: "Enter button speech to speak",
                controller: _buttonSpeechController,
                horizontalHeight: 10.0,
                verticalHeight: 10.0,
              ),
              const SizedBox(height: 20),
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        width: 280,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _buttonCategoryDefaultValue,
                            elevation: 3,
                            isExpanded: true,
                            hint: const Text("Select a button category"),
                            items: [
                              ..._buttonCategories
                                  .map<DropdownMenuItem<String>>(
                                      (String buttonCategory) {
                                return DropdownMenuItem<String>(
                                  value: buttonCategory,
                                  child: Text(buttonCategory),
                                );
                              }).toList(),
                            ],
                            onChanged: (String? value) {
                              setState(() {
                                _buttonCategoryDefaultValue =
                                    value ?? _buttonCategoryDefaultValue;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xffbe29ec),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Add Speech Button",
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 15.7,
                        fontWeight: FontWeight.w700),
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
