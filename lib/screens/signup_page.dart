import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const SignupPage({required this.showLoginPage, super.key});

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
  const SignUpForm({required this.showLoginPage, super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  //text controllers
  final _emailCreateController = TextEditingController();
  final _fullNameCreateController = TextEditingController();
  final _userNameCreateController = TextEditingController();
  final _passwordCreateController = TextEditingController();
  final _confirmPasswordCreateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(43.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Email",
                  style: TextStyle(fontSize: 18, letterSpacing: 0.5),
                ),
                TextFormField(
                  controller: _emailCreateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffe6e1e1),
                      hintText: "Please enter email",
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.all(10),
                      prefixIcon: const Icon(
                        Icons.account_circle_sharp,
                        color: Color(0xffffffff),
                      )),
                ),
              ],
            ), // Email TextField
            const SizedBox(height: 13),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Full Name",
                  style: TextStyle(fontSize: 18, letterSpacing: 0.5),
                ),
                TextFormField(
                  controller: _fullNameCreateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffe6e1e1),
                      hintText: "Please enter full name",
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.all(10),
                      prefixIcon: const Icon(
                        Icons.account_circle_sharp,
                        color: Color(0xffffffff),
                      )),
                ),
              ],
            ), //Full Name TextField
            const SizedBox(height: 13),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Username",
                  style: TextStyle(fontSize: 18, letterSpacing: 0.5),
                ),
                TextFormField(
                  controller: _userNameCreateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffe6e1e1),
                      hintText: "Please enter username",
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.all(10),
                      prefixIcon: const Icon(
                        Icons.account_circle_sharp,
                        color: Color(0xffffffff),
                      )),
                ),
              ],
            ), // Username TextField
            const SizedBox(height: 13),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Password",
                  style: const TextStyle(fontSize: 18, letterSpacing: 0.5),
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordCreateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffe6e1e1),
                      hintText: "Please enter password",
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.all(10),
                      suffixIcon: const Icon(Icons.remove_red_eye),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Color(0xffffffff),
                      )),
                ),
              ],
            ), //Password TextField
            const SizedBox(height: 13),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Confirm Password",
                  style: TextStyle(fontSize: 18, letterSpacing: 0.5),
                ),
                TextFormField(
                  obscureText: true,
                  controller: _confirmPasswordCreateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffe6e1e1),
                      hintText: "Please confirm password",
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.all(10),
                      suffixIcon: const Icon(Icons.remove_red_eye),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Color(0xffffffff),
                      )),
                ),
              ],
            ), //Confirm Password TextField
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Account Created Successfully!')),
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: const Color(0xffbe29ec),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 15)),
                    child: const Text(
                      "Sign Up!",
                      style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 15.7,
                          fontWeight: FontWeight.w700),
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already a member?"),
                GestureDetector(
                    onTap: widget.showLoginPage,
                    child: const Text("Login now!"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
