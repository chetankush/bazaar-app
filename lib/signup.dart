import 'package:flutter/material.dart';
import 'package:baazar/login.dart';
import 'package:baazar/service/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "", password = "", name = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  registration() async {
    if (password != null &&
        nameController.text.isNotEmpty &&
        mailController.text.isNotEmpty) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Registered Successfully",
              style: TextStyle(fontSize: 20.0),
            )));
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Password Provided is too Weak",
                style: TextStyle(fontSize: 18.0),
              )));
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Account Already exists",
                style: TextStyle(fontSize: 18.0),
              )));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(height: 80.0),
              Column(
                children: [
                  Text(
                    "Bazaar",
                    style: TextStyle(fontSize: 54.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "Create an account",
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Sign up to get started",
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildTextField(nameController, "Name"),
                      SizedBox(height: 30.0),
                      buildTextField(mailController, "Email"),
                      SizedBox(height: 30.0),
                      buildTextField(passwordController, "Password", obscureText: true),
                      SizedBox(height: 30.0),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              email = mailController.text;
                              name = nameController.text;
                              password = passwordController.text;
                            });
                          }
                          registration();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 30.0),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40.0),
              Text(
                "or Sign Up with",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      AuthMethods().signInWithGoogle(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please wait we are taking you Home'),
                        ),
                      );
                    },
                    child: Image.asset(
                      "images/google.png",
                      height: 45,
                      width: 45,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 5.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => LogIn()));
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String hintText,
      {bool obscureText = false}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
      decoration: BoxDecoration(
        color: Color(0xFFedf0f8),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please Enter $hintText';
          }
          return null;
        },
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(color: Color(0xFFb2b7bf), fontSize: 18.0),
        ),
        obscureText: obscureText,
      ),
    );
  }
}
