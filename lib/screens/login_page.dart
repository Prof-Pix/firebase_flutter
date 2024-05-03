import 'package:firebase_flutter/firebase_service/firebase_service.dart';
import 'package:flutter/material.dart';

//Importing from the Firebase Auth
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

//Importing from the Screens Folder
import 'forgotpass_page.dart';

//Importing Components from the Component Folder
import 'package:firebase_flutter/components/CustomTextField.dart';
import 'package:firebase_flutter/components/CustomTextPasswordField.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showSignupPage;
  const LoginPage({required this.showSignupPage, super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool value = false;

  // textfield controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isFieldsEmpty() {
    if (_emailController.text.trim().isEmpty || _passwordController.text.trim().isEmpty) {
      return true;
    }
    return false;
  }

  //sign in method
  Future signIn() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      String? loginStatus = await FirebaseService.signInWithEmailAndPassword(email, password);

      if (loginStatus == null) {
        Get.rawSnackbar(messageText: const Text("Login successful."));
      } else if (loginStatus == "InvalidCredential") {
        Get.rawSnackbar(
            messageText: const Text(
          "Invalid Credentials. Please try again.",
          style: TextStyle(color: Colors.white),
        ));
      } else {
        Get.rawSnackbar(messageText: const Text("Unknown error. Please try again later."));
      }
    }
  }

  //dispose
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(alignment: AlignmentDirectional.center, children: [
          Column(
            children: [
              Expanded(
                child: Container(
                    padding: const EdgeInsets.fromLTRB(35, 30, 0, 190),
                    width: double.infinity,
                    color: const Color(0xff660066),
                    child: Row(
                      children: [
                        Container(
                          height: 70,
                          margin: const EdgeInsets.only(right: 10),
                          child: const Column(
                            children: [
                              Text(
                                "Welcome!",
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1,
                                    fontSize: 28),
                              ),
                              Text(
                                "Sign in to continue",
                                style: TextStyle(color: Color(0xffada0a0), fontSize: 15),
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 130),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 300,
                        width: 300,
                        child: Image.asset(
                          'assets/images/speakease_logo.png',
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xffFFFFFF),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade600,
                      spreadRadius: 1.5,
                      blurRadius: 2,
                    )
                  ]),
              width: 300,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      controller: _emailController,
                      hintText: "Please enter email",
                      labelText: "Email",
                      prefixIcon: Icons.account_circle_sharp,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextPasswordField(
                      controller: _passwordController,
                      hintText: "Please enter password",
                      labelText: "Password",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return ForgotPasswordPage();
                              }));
                            },
                            child: const Text("Forgot Password?",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xff800080),
                                    fontWeight: FontWeight.w500)),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                signIn();
                              }
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xffbe29ec),
                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 90),
                            ),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontSize: 15.7,
                                  fontWeight: FontWeight.w700),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Not a member?",
                          style: TextStyle(fontSize: 13),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                            onTap: widget.showSignupPage,
                            child: const Text("Register now!",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xff800080),
                                    fontWeight: FontWeight.w500)))
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
