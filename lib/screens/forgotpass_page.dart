import 'package:flutter/material.dart';

//Importing Components from the Component Folder
import 'package:firebase_flutter/components/CustomTextField.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({Key? key}) : super(key: key);

  final _recoveryEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Forgot Password",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: const Color(0xffE8E8E8),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const Text(
                "Please provide the email associated with your account and receive the reset password link on it.",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffFFFFFF),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade600,
                        spreadRadius: 0.1,
                        blurRadius: 1,
                      )
                    ]),
                child: Column(
                  children: [
                    CustomTextField(
                        labelText: "Recovery Email",
                        hintText: "Please enter recovery email",
                        controller: _recoveryEmailController,
                        prefixIcon: Icons.account_circle_sharp),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                backgroundColor: const Color(0xffbe29ec),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 15)),
                            child: const Text(
                              "Reset Password",
                              style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontSize: 15.7,
                                  fontWeight: FontWeight.w700),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
