import 'package:flutter/material.dart';
import 'forgotpassword.dart';
import 'twostepvalidation.dart';
import 'register.dart';
import 'package:splashscreen/splashscreen.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //await Firebase.initializeApp(
  //    options: FirebaseOptions(
  //        apiKey: "AIzaSyDzgtpvLRAADSXyiHMvJBt1pTYP7GKFaEw", //"api_key": [{"current_key": "AIzaSyDzgtpvLRAADSXyiHMvJBt1pTYP7GKFaEw"}]
  //        appId: "447932810045", //"project_number": "447932810045"
  //        messagingSenderId:  "1:447932810045:android:1798f20550047c0d933b54", //"mobilesdk_app_id": "1:447932810045:android:1798f20550047c0d933b54"
  //        projectId: "firestoresample-9b096" //"project_id": "firestoresample-9b096"
  //    )
  //);

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
        backgroundColor: Colors.pinkAccent,
        styleTextUnderTheLoader: const TextStyle(
          color: Colors.pinkAccent,
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
        image: Image.network('https://i.gzn.jp/img/2023/12/01/kurzgesagt-internet-worse/a00013.jpg'),
        photoSize: 210,
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
                  decorationColor: Colors.pink,
                  fontSize: 45
                )
            ),

            SizedBox(height: 30),

            ///Template pic. Will have one from assets
            Image.network('https://i.gzn.jp/img/2023/12/01/kurzgesagt-internet-worse/a00013.jpg'),
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
              child: Text('Forgot password', style: TextStyle(decoration: TextDecoration.underline)),
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: (){
                if(email.text == "" || password.text == ""){
                  ScaffoldMessenger.of(context).
                  showSnackBar(SnackBar(content: Text('Please provide a valid '
                      'email & password')));
                } else {
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
              child: Text('Sign in', style: TextStyle(fontSize: 40)),
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
              child: Text(
                  'sign up',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
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