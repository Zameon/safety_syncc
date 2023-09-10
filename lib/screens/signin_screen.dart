import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safety_syncc/screens/reset_password.dart';
import 'package:safety_syncc/screens/signup_screen.dart';
import 'package:safety_syncc/screens/location.dart';
import 'package:flutter/animation.dart';
import '../reusable_widgets/reusable_widget_signin.dart';
import '../utils/colors_utils.dart';
import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  String? _errorText;
  late AnimationController _animationController; // Animation controller
  late Animation<double> _fadeAnimation; // Fade-in animation
  late Animation<Offset> _slideAnimation; // Slide-in animation

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(
      begin: .0,
      end: 1.0,
    ).animate(_animationController);

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -5),
      end: Offset(0, 0),
    ).animate(_animationController);
    // Start the animations when the screen loads
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://static.vecteezy.com/system/resources/previews/009/925/006/original/cute-purple-aesthetic-abstract-minimal-background-perfect-for-wallpaper-backdrop-postcard-background-vector.jpg', // Replace with your image URL
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black.withOpacity(0.2), // Add a semi-transparent black overlay
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
                child: Column(
                  children: <Widget>[
                    SlideTransition(
                      position: _slideAnimation,
                      child: Text(
                        "Hola Amigos!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField(
                      "Enter Username",
                      Icons.person_outline,
                      false,
                      _emailTextController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField(
                      "Enter Password",
                      Icons.lock_outline,
                      true,
                      _passwordTextController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    forgetPassword(context),
                    firebaseUIButton(context, "Login", () async {
                      setState(() {
                        _errorText = null;
                      });

                      final email = _emailTextController.text;
                      final password = _passwordTextController.text;

                      if (email.isEmpty || password.isEmpty) {
                        setState(() {
                          _errorText = "Please enter both email and password";
                        });
                      } else {
                        try {
                          final userCredential =
                          await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );

                          if (userCredential.user == null) {
                            setState(() {
                              _errorText = "Invalid email or password";
                            });
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LocationScreen(),
                              ),
                            );
                          }
                        } on FirebaseAuthException catch (e) {
                          setState(() {
                            _errorText = e.message;
                          });
                        } catch (e) {
                          print("Error: $e");
                        }
                      }
                    }),
                    signUpOption(),
                    if (_errorText != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
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
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(color: Colors.white),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignUpScreen(),
              ),
            );
          },
          child: Row(
            children: [
              const Text(
                " Sign Up",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.arrow_forward, // Add your preferred icon here
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              "Forgot Password?",
              style: TextStyle(color: Colors.white),
            ),
            Icon(
              Icons.help_outline, // Add your preferred icon here
              color: Colors.white,
            ),
          ],
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResetPassword(),
          ),
        ),
      ),
    );
  }
}
