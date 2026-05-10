import 'package:flutter/material.dart';
import 'forgotpassword.dart';
import 'twostepvalidation.dart';
import 'register.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RegExp emailReg = RegExp(r'^[A-Za-z0-9_-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
  String errorMessage = '';

  bool inputFormatCheck(String? input, [RegExp? regex]){
    if(input == null || input.trim().isEmpty) {
      errorMessage = 'Please do not leave the email or password empty';
      return false;

    } else {
      if (regex != null && !regex.hasMatch(input.trim())) {
        errorMessage = 'Please ensure the email is formatted as such: '
        'name@email.domain';
        return false;

      } else {
        return true;
      }
    }
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> errorSnack(){
    return ScaffoldMessenger.of(context).
    showSnackBar(SnackBar(content: Text(errorMessage)));
  }

  Future<void> loginUser() async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      if (userCredential.user != null && !userCredential.user!.emailVerified) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please verify your email before logging in.")),
        );
        return;
      }

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ValidatePage(
            email: email.text.trim(),
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = "Login failed.";

      if (e.code == "user-not-found") {
        message = "No account found with this email.";
      } else if (e.code == "wrong-password") {
        message = "Incorrect password.";
      } else if (e.code == "invalid-email") {
        message = "Invalid email.";
      } else if (e.code == "invalid-credential") {
        message = "Incorrect email or password.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom
        ),
        child: Column(
          children: [
            const SizedBox(height: 60),
            const Text('Welcome to\nDopa-Miner!',
                style: TextStyle(
                  color: Colors.pinkAccent,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.green,
                  fontSize: 45
                )
            ),

            const SizedBox(height: 30),

            Image.asset('assets/dopaminerlogo.png'),
            Padding(padding: EdgeInsets.only(left: 50, right: 50, top: 50),
              child: Column(
                children: [
                  TextField(
                    controller: email,
                    decoration: const InputDecoration(
                        labelText: "Enter your email",
                        labelStyle: TextStyle(
                          color: Colors.pinkAccent,
                        )
                    ),
                  ),

                  SizedBox(height: 20),

                  TextField(
                    controller: password,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: "Enter your password",
                        labelStyle: TextStyle(
                          color: Colors.pinkAccent,
                        )
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            TextButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PasswordPage(),
                  ),
                );
              },
              style: TextButton.styleFrom(
                overlayColor: Colors.transparent,
              ),
              child: const Text('Forgot password',
                style: TextStyle(
                  color: Colors.indigo,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.indigo
                )
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green
              ),
              onPressed: (){
                if(!inputFormatCheck(email.text, emailReg) ||
                   !inputFormatCheck(password.text)) {
                  errorSnack();
                }
                //else if () {} //For Firebase checks
                else {
                  //Navigator.push(
                  //  context,
                  //  MaterialPageRoute(
                  //    builder: (context) => ValidatePage(
                  //      email: email.text
                  //    ),
                  // ),
                  //);
                  loginUser();
                }
              },
              child: const Text('Sign in',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40
                )
              ),
            ),

            TextButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(),
                  ),
                );
              },
              style: TextButton.styleFrom(
                overlayColor: Colors.transparent,
              ),
              child: const Text(
                'sign up',
                style: TextStyle(
                  color: Colors.indigo,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.indigo,
                  fontSize: 25
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}