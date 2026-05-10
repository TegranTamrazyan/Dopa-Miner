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
            const SizedBox(height: 60),
            const Text('Please Confirm\nyour email',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.pinkAccent,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.green,
                    fontSize: 45
                )
            ),

            const SizedBox(height: 20),

            Image.asset('assets/dopaminerlogo.png'),
            Padding(padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
              child: Column(
                children: [
                  TextField(
                    controller: code,
                    decoration: const InputDecoration(
                        labelText: "Enter the 6 digit code sent to your email",
                        labelStyle: TextStyle(
                          color: Colors.pinkAccent,
                        )
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextButton(
                    onPressed: (){
                      ScaffoldMessenger.of(context).
                      showSnackBar(const SnackBar(content: Text('A new 6 digit code'
                          'was sent to the provided email')));
                    },
                    child: const Text(
                        'Re-send code',
                        style: TextStyle(
                            color: Colors.indigo,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.indigo,
                            fontSize: 20
                        )
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent
                  ),
                  onPressed: (){
                      Navigator.pop(context);
                  },
                  child: const Text('Cancel',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30
                      )
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green
                  ),
                  onPressed: (){
                    if(code.text.trim().isEmpty || int.tryParse(code.text.trim()) == null){
                      ScaffoldMessenger.of(context).
                          showSnackBar(const SnackBar(content: Text('Please enter a valid code '
                              'with only numbers')));
                    } else {
                        Navigator.pop(context);
                    }
                  },
                  child: const Text('Enter App',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30
                      )
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}