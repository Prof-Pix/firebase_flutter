import 'package:flutter/material.dart';

////Importing from the Firebase Auth
import 'package:firebase_auth/firebase_auth.dart';

//Importing Components from the Component Folder
import 'package:firebase_flutter/components/CustomTextField.dart';
import 'package:firebase_flutter/components/CustomTextPasswordField.dart';

class SignupPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const SignupPage({required this.showLoginPage, Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffffffff),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 100,
              decoration: const BoxDecoration(
                  color: Color(0xff800080),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: Center(
                child: Text(
                  "Create your account".toUpperCase(),
                  style: const TextStyle(
                      letterSpacing: 0.5,
                      color: Color(0xffffffff),
                      fontSize: 21.5,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            SignUpForm(
              showLoginPage: widget.showLoginPage,
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  final VoidCallback showLoginPage;
  const SignUpForm({required this.showLoginPage, Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  //For SnackBar
  bool _isSnackBarDisplayed = false;

  //For Validation & Snackbar Function
  void showSnackBar(String textToDisplay) {
    //We check first if there is a currently displayed snackbar
    if (!_isSnackBarDisplayed) {
      setState(() {
        _isSnackBarDisplayed = true;
        ScaffoldMessenger.of(context)
            .showSnackBar(
              SnackBar(
                content: Text(textToDisplay),
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 2),
              ),
            )
            .closed
            .then((_) => {
                  setState(() {
                    _isSnackBarDisplayed = false;
                  })
                });
      });
    }
  }

  //For Creating the Username and Pass
  Future signUp() async {
    try {
      if (isPasswordConfirmed()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailCreateController.text.trim(),
          password: _passwordCreateController.text.trim(),
        );

        showSnackBar("Account Created Successfully!");
      } else {
        showSnackBar("Passwords must match. Please try again.");
      }
    } catch (e) {
      showSnackBar("Signup Failed. Please try again.");
    }
  }

  // Text controllers
  final _emailCreateController = TextEditingController();
  final _fullNameCreateController = TextEditingController();
  final _userNameCreateController = TextEditingController();
  final _passwordCreateController = TextEditingController();
  final _confirmPasswordCreateController = TextEditingController();

  //For confirming the password
  bool isPasswordConfirmed() {
    if (_passwordCreateController.text.trim() ==
        _confirmPasswordCreateController.text.trim()) {
      return true;
    }
    return false;
  }

  final double fieldSpaceSizeHeight = 10;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(
              labelText: 'Email',
              hintText: 'Please enter email',
              controller: _emailCreateController,
              prefixIcon: Icons.account_circle_sharp,
              regex: RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              labelText: 'Full Name',
              hintText: 'Please enter full name',
              controller: _fullNameCreateController,
              prefixIcon: Icons.account_circle_sharp,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              labelText: 'Username',
              hintText: 'Please enter username',
              controller: _userNameCreateController,
              prefixIcon: Icons.account_circle_sharp,
            ),
            const SizedBox(height: 10),
            CustomTextPasswordField(
              labelText: 'Password',
              hintText: 'Please enter password',
              controller: _passwordCreateController,
            ),
            const SizedBox(height: 10),
            CustomTextPasswordField(
              labelText: 'Confirm Password',
              hintText: 'Please confirm password',
              controller: _confirmPasswordCreateController,
            ),
            const SizedBox(height: 12.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      signUp();
                    } else {
                      showSnackBar(
                          "Bad try. Please check all required fields.");
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xffbe29ec),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 10,
                    ),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 15.7,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already a member?"),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: widget.showLoginPage,
                  child: const Text(
                    "Login now!",
                    style: TextStyle(
                        color: Color(0xff800080), fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
