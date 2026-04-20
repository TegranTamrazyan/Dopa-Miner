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
            Text('Create an Account\nA Dopa-Miner Account!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.pinkAccent,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.pink,
                    fontSize: 30
                )
            ),

            SizedBox(height: 40),

            Image.network('https://i.gzn.jp/img/2023/12/01/kurzgesagt-internet-worse/a00013.jpg'),
            Padding(padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                        color: Colors.pinkAccent,
                          width: 1
                        ),
                          borderRadius: BorderRadius.circular(25)
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 0, bottom: 15
                        ),
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
                            SizedBox(height: 5),

                            TextField(
                              controller: lname,
                              decoration: InputDecoration(
                                  labelText: "Last name",
                                  labelStyle: TextStyle(
                                    color: Colors.pinkAccent,
                                  )
                              ),
                            ),

                            SizedBox(height: 5),

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
                    ),
                  ),

                  SizedBox(width: 10),

                  Expanded(
                    child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.pinkAccent,
                        width: 1
                      ),
                      borderRadius: BorderRadius.circular(25)
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 0, bottom: 15
                      ),
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
                          SizedBox(height: 5),

                          TextField(
                            controller: password,
                            decoration: InputDecoration(
                                labelText: "password",
                                labelStyle: TextStyle(
                                  color: Colors.pinkAccent,
                                )
                            ),
                          ),

                          SizedBox(height: 5),

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
                  )
                  )
                ],
              ),
            ),

            SizedBox(height: 25),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent
              ),
              onPressed: (){
                if(email.text.trim() == "" || password.text.trim() == ""){
                  ScaffoldMessenger.of(context).
                  showSnackBar(SnackBar(content: Text('Please provide a valid '
                      'information in each field')));
                } else {
                  ScaffoldMessenger.of(context).
                  showSnackBar(SnackBar(content: Text('THIS WORKS!')));
                  ///Needs to also create an account in the db
                  Navigator.pop(context);
                }

              },
              child: Text('Register', style: TextStyle(color: Colors.white,fontSize: 40)),
            ),

            TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text(
                  'Back to login page',
                  style: TextStyle(
                    color: Colors.pinkAccent,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.pinkAccent,
                    fontSize: 25
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}