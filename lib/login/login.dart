import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
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
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 70),
              Text('Welcome to\nDopa-Miner!',
                  style: TextStyle(
                  color: Colors.pinkAccent,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.pink,
                  fontSize: 45
              )),
              SizedBox(height: 30),
              Image.network('https://i.gzn.jp/img/2023/12/01/kurzgesagt-internet-worse/a00013.jpg'),
              Padding(padding: EdgeInsets.symmetric(horizontal: 100, vertical: 50),
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
                      textAlign: TextAlign.center,
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
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              TextButton(onPressed: (){
                if(email.text == "" || password.text == ""){
                  ScaffoldMessenger.of(context).
                  showSnackBar(SnackBar(content: Text('Please provide a valid email & password')));
                } else {
                  ScaffoldMessenger.of(context).
                  showSnackBar(SnackBar(content: Text('THIS WORKS!')));
                  /*
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StorePage(
                          username: name.text
                      ),
                    ),
                  );
                  */
                }

              },
                child: Text(
                  'Visit',
                  style: TextStyle(
                      color: Colors.lightGreen,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.lightGreen,
                      fontSize: 40
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}