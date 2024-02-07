import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool value = false;
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
                                style: TextStyle(
                                    color: Color(0xffada0a0), fontSize: 15),
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 60),
                              width: 150,
                              child: const Image(
                                image:
                                    AssetImage("assets/images/pic_login.png"),
                              ),
                            )
                          ],
                        )
                      ],
                    )),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 130),
                  child: Container(
                    width: 300,
                    child: const Image(
                        image: AssetImage('assets/images/speakease_logo.png')),
                  ),
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(34.8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xffFFFFFF),
            ),
            width: 354.3,
            height: 326.7,
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffe6e1e1),
                      hintText: "Email",
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.all(10),
                      prefixIcon: const Icon(
                        Icons.account_circle_sharp,
                        color: Color(0xffffffff),
                      )),
                ),
                const SizedBox(
                  height: 28.8,
                ),
                TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffe6e1e1),
                      hintText: "Password",
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.all(10),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Color(0xffffffff),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(17, 15, 17, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 0,
                            width: 20,
                            child: Transform.scale(
                              scale: 0.7,
                              child: Checkbox(
                                  value: value,
                                  onChanged: (value) {
                                    setState(() {
                                      value = value;
                                    });
                                  }),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "Remember me",
                            style: TextStyle(
                                fontSize: 10, color: Color(0xff000000)),
                          )
                        ],
                      ),
                      const Text("Forgot Password?",
                          style: TextStyle(fontSize: 10))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24.3,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                              backgroundColor: const Color(0xffbe29ec)),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                color: Color(0xffffffff),
                                fontSize: 15.7,
                                fontWeight: FontWeight.w700),
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 10),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Create an account", style: TextStyle(fontSize: 10))
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
