import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login/login.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAIZ0TdRQwe1NVo18iFuXpyAUQj2q7o0qU", //"api_key": [{"current_key": "AIzaSyDzgtpvLRAADSXyiHMvJBt1pTYP7GKFaEw"}]
          appId: "267231609387", //"project_number": "447932810045"
          messagingSenderId:  "1:267231609387:android:6284bc41ec8884585fe06e", //"mobilesdk_app_id": "1:447932810045:android:1798f20550047c0d933b54"
          projectId: "dopaminer-bb5fd" //"project_id": "firestoresample-9b096"
      )

    //I'm testing in my own firebase, I'll save the one we have shared here:

    // apiKey: "AIzaSyAIZ0TdRQwe1NVo18iFuXpyAUQj2q7o0qU",
    // appId: "267231609387",
    // messagingSenderId:  "1:267231609387:android:6284bc41ec8884585fe06e",
    // projectId: "dopaminer-bb5fd"


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