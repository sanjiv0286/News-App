import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'homepage.dart';
import 'mainscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> signin(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // ignore: unnecessary_null_comparison
      if (userCredential != null) {
        // ignore: use_build_context_synchronously
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MainScreen()));
      } else {
        stdout.write("Sign In Failed");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        stdout.write('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        stdout.write('The account already exists for that email.');
      }
    } catch (e) {
      stdout.write(e);
    }
  }

  // ignore: prefer_typing_uninitialized_variables
  var keys; //**************/
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "MyNews",
                    style: TextStyle(
                      color: Color.fromARGB(255, 2, 49, 131),
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 150),
              // ******************
              Forms2(
                emailController: emailController,
                passwordController: passwordController,
                formKey: _formKey,
              ),
              // const Forms2(),
              // ********************
              const SizedBox(
                height: 100,
              ),
              Container(
                // color: Colors.blueAccent,
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: Column(
                    children: [
                      CupertinoButton(
                        color: const Color.fromARGB(255, 30, 12, 223),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          signin(context);
                          // ******************
                          // if (keys.currentState!.validate()) {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(
                          //         content: Text("Validation is Going On")));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const MainScreen()));
                          // }
                          // *********************
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "New here ?",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()));
                            },
                            child: const Text(
                              "Signup",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Forms2 extends StatefulWidget {
  const Forms2(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.formKey});

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  State<Forms2> createState() => _Forms2State();
}

class _Forms2State extends State<Forms2> {
  // ignore: prefer_typing_uninitialized_variables
  var keys; //**************/
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Form(
          key: keys,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: widget.emailController,
                  // obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.w500),
                    hintText: "Enter Email",
                    icon: Icon(Icons.email, color: Colors.blue),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "please fill the details";
                    }
                    return null;
                  },
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return "please fill the details";
                  //   }
                  //   return null;
                  // },
                ),
                TextFormField(
                  controller: widget.passwordController,
                  obscureText: true,

                  decoration: const InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                    hintText: "Enter Password",
                    icon: Icon(Icons.lock),
                  ),

                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "please fill the details";
                    }
                    return null;
                  },
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return "please fill the details";
                  //   }
                  //   return null;
                  // },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
