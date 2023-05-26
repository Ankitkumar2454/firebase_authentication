import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth/main.dart';
import 'package:firebaseauth/screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _secureText = true;
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future login({String? email, String? password}) async {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please check the email and password again"),
        backgroundColor: Colors.red,
      ));
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 6, 230),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Center(
          child: Text(
            "Sign In Page",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.055,
                  // height: 50,
                ),
                Container(
                  height: size.height * 0.103,
                  width: size.height * 0.33,
                  child: Center(
                    child: const Text(
                      "Welcome, Back",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontFamily: "Google Sans"),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.055,
                ),
                Column(
                  children: [
                    TextFormField(
                      controller: usernameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "email cannot be empty";
                        } else if (EmailValidator.validate(
                                usernameController.text.trim()) ==
                            false) {
                          return "verify email and password again ";
                        } else {
                          return null;
                        }
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Container(
                            height: size.height * 0.020,
                            width: size.width * 0.020,
                            // height: 20,
                            // width: 20,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 2),
                              child: Icon(
                                Icons.mail,
                                color: Color(0xffFFFFFF),
                              ),
                            ),
                          ),
                        ),
                        hintText: "User Email",
                        hintStyle: const TextStyle(
                          fontFamily: "Avenir",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.031,
                    ),
                    // password
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty)
                          return "password cannot be empty";
                        else if (value.length < 8)
                          return "password must be atleast 8";
                        else {
                          return null;
                        }
                      },
                      style: TextStyle(color: Colors.white),
                      obscureText: _secureText,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Container(
                            // height: 20,
                            // width: 20,
                            height: size.height * 0.020,
                            width: size.width * 0.020,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 2),
                              child: Icon(
                                Icons.lock,
                                color: Color(0xffFFFFFF),
                              ),
                            ),
                          ),
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _secureText = !_secureText;
                              });
                            },
                            icon: _secureText
                                ? const Icon(
                                    CupertinoIcons.eye_slash_fill,
                                    color: Color(0xffFFFFFF),
                                  )
                                : const Icon(
                                    CupertinoIcons.eye_fill,
                                    color: Color(0xffFFFFFF),
                                  )),
                        hintText: "Password",
                        hintStyle: const TextStyle(
                          fontFamily: "Avenir",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_formkey.currentState!.validate()) {
                        login(
                          email: usernameController.text.toString(),
                          password: passwordController.text.toString(),
                        );
                      }
                    });
                  },
                  child: Center(
                    child: Container(
                      // height: 56,
                      // width: 311,
                      height: size.height * 0.065,
                      width: size.width * 0.81,
                      // color: Colors.red,
                      child: Container(
                        // height: 30,
                        // width: 311,
                        height: size.height * 0.036,
                        width: size.width * 0.81,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(96),
                          color: Color(0xff21C4A7),
                        ),
                        child: const Center(
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.031,
                ),
                Center(
                  child: Container(
                    height: size.height * 0.031,
                    width: size.width * 0.65,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: size.height * 0.025,
                          width: size.width * 0.45,
                          child: const Text(
                            "Don’t have an account ?",
                            style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 15,
                              fontFamily: 'Google Sans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp())),
                          child: Container(
                            height: size.height * 0.028,
                            width: size.width * 0.189,
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color(0xffFFFFFF),
                                fontSize: 16,
                                fontFamily: 'Google Sans',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
