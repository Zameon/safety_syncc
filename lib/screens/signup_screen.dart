import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safety_syncc/screens/signin_screen.dart';

import '../reusable_widgets/reusable_widget_signup.dart';
import '../utils/colors_utils.dart';
import '../screens/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://static.vecteezy.com/system/resources/previews/009/925/006/original/cute-purple-aesthetic-abstract-minimal-background-perfect-for-wallpaper-backdrop-postcard-background-vector.jpg', // Replace with your image URL
              //'https://png.pngtree.com/thumb_back/fh260/background/20230125/pngtree-aesthetic-purple-shapes-with-blots-image_1539637.jpg', // Replace with your image URL
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(

                  height: 20,
                ),
                reusableTextField(

                  "Enter Username",
                  Icons.person_outline,
                  false,
                  _userNameTextController,
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                  "Enter Your Email",
                  Icons.person_outline,
                  false,
                  _emailTextController,
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                  "Enter Password",
                  Icons.lock_outlined,
                  true,
                  _passwordTextController,
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                  "Enter Phone Number",
                  Icons.phone,
                  false,
                  _phoneNumberController,
                ),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Register", () async {
                  setState(() {
                    _errorText = null;
                  });

                  final email = _emailTextController.text;
                  final password = _passwordTextController.text;
                  final phoneNumber = _phoneNumberController.text;

                  if (email.isEmpty || password.isEmpty || phoneNumber.isEmpty) {
                    setState(() {
                      _errorText = "Please fill in all fields";
                    });
                    return;
                  }

                  if (!isValidPhoneNumber(phoneNumber)) {
                    setState(() {
                      _errorText = "Invalid phone number format";
                    });
                    return;
                  }

                  try {
                    final userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    if (userCredential.user == null) {
                      setState(() {
                        _errorText = "Account creation failed";
                      });
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInScreen(),
                        ),
                      );
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'email-already-in-use') {
                      setState(() {
                        _errorText = "This email is already in use";
                      });
                    } else {
                      setState(() {
                        _errorText = e.message;
                      });
                    }
                  } catch (e) {
                    print("Error: $e");
                  }
                }),
                if (_errorText != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      _errorText!,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
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

  bool isValidPhoneNumber(String phoneNumber) {
    return phoneNumber.length == 11 && int.tryParse(phoneNumber) != null;
  }
}
