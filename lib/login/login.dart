import 'package:flutter/material.dart';
import 'forgotpassword.dart';
import 'twostepvalidation.dart';
import 'register.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAIZ0TdRQwe1NVo18iFuXpyAUQj2q7o0qU", //"api_key": [{"current_key": "AIzaSyDzgtpvLRAADSXyiHMvJBt1pTYP7GKFaEw"}]
          appId: "267231609387", //"project_number": "447932810045"
          messagingSenderId:  "1:267231609387:android:6284bc41ec8884585fe06e", //"mobilesdk_app_id": "1:447932810045:android:1798f20550047c0d933b54"
          projectId: "dopaminer-bb5fd" //"project_id": "firestoresample-9b096"
      )
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
        seconds: 5,
        navigateAfterSeconds: LoginPage(),
        title: const Text(
          'Welcome to Dopa-Miner',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white,
          )
        ),
        backgroundColor: Colors.red,
        styleTextUnderTheLoader: const TextStyle(
          color: Colors.white,
          fontSize: 45
        ),
        loadingText: const Text(
          'Brought to you by Ehsan & Tegran\nVanier AppDev2 project',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20
          )
        ),
        loadingTextPadding: EdgeInsets.zero,
        useLoader: false,
        loaderColor: Colors.white,
        image: Image.asset('assets/vanierlogo.png'),
        photoSize: 200,
      ),
    );
  }
}

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
            SizedBox(height: 60),
            Text('Welcome to\nDopa-Miner!',
                style: TextStyle(
                  color: Colors.pinkAccent,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.green,
                  fontSize: 45
                )
            ),

            SizedBox(height: 30),

            Image.asset('assets/dopaminerlogo.png'),
            Padding(padding: EdgeInsets.only(left: 50, right: 50, top: 50),
              child: Column(
                children: [
                  TextField(
                    controller: email,
                    decoration: InputDecoration(
                        labelText: "Enter your email",
                        labelStyle: TextStyle(
                          color: Colors.pinkAccent,
                        )
                    ),
                  ),

                  SizedBox(height: 20),

                  TextField(
                    controller: password,
                    decoration: InputDecoration(
                        labelText: "Enter your password",
                        labelStyle: TextStyle(
                          color: Colors.pinkAccent,
                        )
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

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

            SizedBox(height: 30),

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ValidatePage(
                        email: email.text
                      ),
                    ),
                  );
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
              child: Text(
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