import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController age = TextEditingController();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController verif = TextEditingController();

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
            SizedBox(height: 70),
            Text('Welcome to Dopa-Miner!',
                style: TextStyle(
                    color: Colors.pinkAccent,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.pink,
                    fontSize: 30
                )
            ),

            SizedBox(height: 30),

            Image.network('https://i.gzn.jp/img/2023/12/01/kurzgesagt-internet-worse/a00013.jpg'),
            Padding(padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextField(
                          controller: fname,
                          decoration: InputDecoration(
                              labelText: "First name",
                              labelStyle: TextStyle(
                                color: Colors.pinkAccent,
                              )
                          ),
                        ),
                        SizedBox(height: 20),

                        TextField(
                          controller: lname,
                          decoration: InputDecoration(
                              labelText: "Last name",
                              labelStyle: TextStyle(
                                color: Colors.pinkAccent,
                              )
                          ),
                        ),

                        SizedBox(height: 20),

                        TextField(
                          controller: age,
                          decoration: InputDecoration(
                              labelText: "Age",
                              labelStyle: TextStyle(
                                color: Colors.pinkAccent,
                              )
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 30),

                  Expanded(
                    child: Column(
                      children: [
                        TextField(
                          controller: email,
                          decoration: InputDecoration(
                              labelText: "email",
                              labelStyle: TextStyle(
                                color: Colors.pinkAccent,
                              )
                          ),
                        ),
                        SizedBox(height: 20),

                        TextField(
                          controller: password,
                          decoration: InputDecoration(
                              labelText: "password",
                              labelStyle: TextStyle(
                                color: Colors.pinkAccent,
                              )
                          ),
                        ),

                        SizedBox(height: 20),

                        TextField(
                          controller: verif,
                          decoration: InputDecoration(
                              labelText: "confirm password",
                              labelStyle: TextStyle(
                                color: Colors.pinkAccent,
                              )
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: (){
                if(email.text.trim() == "" || password.text.trim() == ""){
                  ScaffoldMessenger.of(context).
                  showSnackBar(SnackBar(content: Text('Please provide a valid '
                      'information in each field')));
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
              child: Text('Register', style: TextStyle(fontSize: 40)),
            ),

            TextButton(
              onPressed: (){
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