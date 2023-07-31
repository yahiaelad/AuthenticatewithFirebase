import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterpro/views/todos_screan.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home_Page.dart';

class loginscrean extends StatefulWidget {
  const loginscrean({super.key});

  @override
  State<loginscrean> createState() => _loginscreanState();
}

class _loginscreanState extends State<loginscrean> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailconteroler = TextEditingController();
  TextEditingController passwordconteroler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 202, 219, 214),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("login page"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  width: 150,
                  height: 150,
                  child: Image.asset("assets/logo.png"),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  controller: emailconteroler,
                  decoration: InputDecoration(labelText: "E-mail"),
                  validator: (value) {
                    if (value!.isNotEmpty && value.contains("@")) {
                      return null;
                    } else {
                      return "add valid email";
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                    controller: passwordconteroler,
                    decoration: InputDecoration(labelText: "password"),
                    validator: (value) {
                      if (value!.length < 8) {
                        return "enter valid password";
                      }
                    }),
              ),
              CupertinoButton.filled(
                onPressed: () async {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // Obtain shared preferences.
                    bool result = await firebaselogin(
                        emailconteroler.text, passwordconteroler.text);
                    if (result) {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      // Save an String value to 'action' key.
                      await prefs.setString('email', emailconteroler.text);
                      firebaselogin(
                          emailconteroler.text, passwordconteroler.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => todosscrean(
                                //email: emailconteroler.text
                                )),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('email or passwor error')),
                      );
                    }
                  }
                },
                child: const Text('Login (go to todo)'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> firebaselogin(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (credential.user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return false;
  }
}
