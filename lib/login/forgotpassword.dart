import 'package:flutter/material.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  bool isVisible = false;

  TextEditingController email = TextEditingController();

  TextEditingController code = TextEditingController();

  TextEditingController newPass = TextEditingController();
  TextEditingController rePass = TextEditingController();


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

            SizedBox(height: 20),

            Image.network('https://i.gzn.jp/img/2023/12/01/kurzgesagt-internet-worse/a00013.jpg'),
            Padding(padding: EdgeInsets.only(left: 50, right: 50, top: 10),
              child: Column(
                children: [
                  TextField(
                    controller: email,
                    decoration: InputDecoration(
                        labelText: "Your email",
                        labelStyle: TextStyle(
                          color: Colors.pinkAccent,
                        )
                    ),
                  ),

                  SizedBox(height: 10),

                  TextButton(
                    onPressed: (){
                      ScaffoldMessenger.of(context).
                      showSnackBar(SnackBar(content: Text('A validation request was sent'
                          ' to the provided email')));
                    },
                    child: Text(
                        'verify email',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 20
                        )
                    ),
                  ),

                  SizedBox(height: 5),

                  ///Make these TextFields invisible till email clicks button to confirm?
                  TextField(
                    controller: newPass,
                    decoration: InputDecoration(
                        labelText: "Your new password",
                        labelStyle: TextStyle(
                          color: Colors.pinkAccent,
                        )
                    ),
                  ),

                  SizedBox(height: 15),

                  TextField(
                    controller: rePass,
                    decoration: InputDecoration(
                        labelText: "Re-enter the new password",
                        labelStyle: TextStyle(
                          color: Colors.pinkAccent,
                        )
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40),

            ElevatedButton(
              onPressed: (){
                if(newPass.text == "" || newPass.text != rePass.text){
                  ScaffoldMessenger.of(context).
                  showSnackBar(SnackBar(content: Text('Please provide a valid '
                      'email & password')));
                } else {
                  Navigator.pop(context);
                }
              },
              child: Text('Confirm change', style: TextStyle(fontSize: 30)),
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