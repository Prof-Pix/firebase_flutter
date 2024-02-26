import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  //For Creating the Username and Pass
  Future signUp() async {
    try {
      if (isPasswordConfirmed()) {
        print(_emailCreateController.text);

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailCreateController.text.trim(),
          password: _passwordCreateController.text.trim(),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account Created Successfully!'),
          ),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Signup Failed. Please try again.'),
        ),
      );
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(43.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(
              labelText: 'Email',
              hintText: 'Please enter email',
              controller: _emailCreateController,
              prefixIcon: Icons.account_circle_sharp,
            ),
            const SizedBox(height: 15),
            CustomTextField(
              labelText: 'Full Name',
              hintText: 'Please enter full name',
              controller: _fullNameCreateController,
              prefixIcon: Icons.account_circle_sharp,
            ),
            const SizedBox(height: 15),
            CustomTextField(
              labelText: 'Username',
              hintText: 'Please enter username',
              controller: _userNameCreateController,
              prefixIcon: Icons.account_circle_sharp,
            ),
            const SizedBox(height: 15),
            CustomTextField(
              labelText: 'Password',
              hintText: 'Please enter password',
              controller: _passwordCreateController,
              prefixIcon: Icons.lock,
              obscureText: false,
              suffixIcon: Icons.remove_red_eye,
            ),
            const SizedBox(height: 15),
            CustomTextField(
              labelText: 'Confirm Password',
              hintText: 'Please confirm password',
              controller: _confirmPasswordCreateController,
              prefixIcon: Icons.lock,
              obscureText: false,
              suffixIcon: Icons.remove_red_eye,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      signUp();
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xffbe29ec),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    "Sign Up!",
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 15.7,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
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

class CustomTextField extends StatelessWidget {
  final String _labelText;
  final String _hintText;
  final TextEditingController _controller;
  final IconData _prefixIcon;
  final IconData? _suffixIcon;
  final bool _obscureText;

  const CustomTextField({
    required String labelText,
    required String hintText,
    required TextEditingController controller,
    required IconData prefixIcon,
    IconData? suffixIcon,
    bool obscureText = false,
    Key? key,
  })  : _labelText = labelText,
        _hintText = hintText,
        _controller = controller,
        _prefixIcon = prefixIcon,
        _suffixIcon = suffixIcon,
        _obscureText = obscureText,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _labelText,
          style: const TextStyle(fontSize: 18, letterSpacing: 0.5),
        ),
        TextFormField(
          obscureText: _obscureText,
          controller: _controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "This field is required";
            }
            return null;
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xffe6e1e1),
            hintText: _hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(10),
            prefixIcon: Icon(
              _prefixIcon,
              color: const Color(0xffffffff),
            ),
            suffixIcon: _suffixIcon != null
                ? Icon(
                    _suffixIcon,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
