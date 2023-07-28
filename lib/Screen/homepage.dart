import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loginscreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ignore: prefer_typing_uninitialized_variables
  var keys; //**************/

  Future<void> signup(BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.text, password: _password.text);
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Registration Successful'),
            content: const Text('You have successfully registered.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  // Close the dialog and navigate back to the login screen
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
              // ********************
              // const Forms1(),
              Forms1(
                usernameController: _username,
                emailController: _email,
                passwordController: _password,
                formKey: _formKey,
              ),
      
              // *********************
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
                        color: const Color.fromARGB(255, 40, 11, 233),
                        child: const Text(
                          "Signup",
                          style: TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          signup(context);
                          // ignore: prefer_typing_uninitialized_variables
                          // var keys;//*************/
                          // if (keys.currentState!.validate()) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //       const SnackBar(
                          //           content: Text("Validation is Going On")));
                          // }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Already Have an Account ?",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginScreen()));
                            },
                            child: const Text(
                              "Login",
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

class Forms1 extends StatefulWidget {
  // *****************************
  const Forms1(
      {super.key,
      required this.usernameController,
      required this.emailController,
      required this.passwordController,
      required this.formKey});
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  // const Forms1({
  //   super.key,
  //   required this.usernameController,
  //   required this.emailController,
  //   required this.passwordController,
  //   required this.formKey,
  // });

  @override
  State<Forms1> createState() => _Forms1State();
}

class _Forms1State extends State<Forms1> {
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
                  // controller: _username,
                  controller: widget.usernameController,

                  decoration: const InputDecoration(
                    labelText: "Name",
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                    ),
                    hintText: "Enter Your Name",
                    icon: Icon(Icons.person),
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
                  // controller: _email,
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
                  // controller: _password,
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

