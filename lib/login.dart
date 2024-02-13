import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:baazar/forgot_password.dart';
import 'package:baazar/home.dart';
import 'package:baazar/service/auth.dart';
import 'package:baazar/signup.dart';
import 'cartProvider.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String email = "";
  String password = "";

  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  userLogin(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "No User Found for that Email",
            style: TextStyle(fontSize: 18.0),
          ),
        ));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "Wrong Password Provided by User",
            style: TextStyle(fontSize: 18.0),
          ),
        ));
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
                  // Image.asset(
                  //   "images/car.png",
                  //   height: 120,
                  // ),

                  Text(
                    "Bazaar",
                    style: TextStyle(fontSize: 54.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "Welcome back!",
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Sign in to continue",
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 40.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildTextField(mailController, "Email"),
                      SizedBox(height: 30.0),
                      buildTextField(
                        passwordController,
                        "Password",
                        obscureText: true,
                      ),
                      SizedBox(height: 12.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPassword(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              email = mailController.text;
                              password = passwordController.text;
                            });
                          }
                          userLogin(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 30.0),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: Text(
                              "Sign In",
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
                "or Sign In with",
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
                    "Don't have an account?",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 5.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
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
