import 'package:flutter/material.dart';
import 'forgotpassword.dart';
import 'twostepvalidation.dart';
import 'register.dart';


class ValidatePage extends StatefulWidget {
  final String email;
  const ValidatePage({required this.email});

  @override
  State<ValidatePage> createState() => _ValidatePageState();
}

class _ValidatePageState extends State<ValidatePage> {
  TextEditingController code = TextEditingController();

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
            Text('Please Confirm\nyour email',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.pinkAccent,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.pink,
                    fontSize: 45
                )
            ),

            SizedBox(height: 20),

            Image.network('https://i.gzn.jp/img/2023/12/01/kurzgesagt-internet-worse/a00013.jpg'),
            Padding(padding: EdgeInsets.only(left: 50, right: 50, top: 10),
              child: Column(
                children: [
                  TextField(
                    controller: code,
                    decoration: InputDecoration(
                        labelText: "Enter the 6 digit code sent to your email",
                        labelStyle: TextStyle(
                          color: Colors.pinkAccent,
                        )
                    ),
                  ),

                  SizedBox(height: 10),

                  TextButton(
                    onPressed: (){
                      ScaffoldMessenger.of(context).
                      showSnackBar(SnackBar(content: Text('A new 6 digit code'
                          'was sent to the provided email')));
                    },
                    child: Text(
                        'Re-send code',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 20
                        )
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40),

            ElevatedButton(
              onPressed: (){
                ///template validation
                if(code.text == ""){
                  ScaffoldMessenger.of(context).
                  showSnackBar(SnackBar(content: Text('Please provide a valid '
                      'email & password')));
                } else {
                  Navigator.pop(context);
                }
              },
              child: Text('Enter App', style: TextStyle(fontSize: 30)),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('Back to the login page', style: TextStyle(fontSize: 30)),
            ),
          ],
        ),
      ),
    );
  }
}