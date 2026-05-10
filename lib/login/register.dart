import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with SingleTickerProviderStateMixin{
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController verif = TextEditingController();

  RegExp emailReg = RegExp(r'^[A-Za-z0-9_-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
  RegExp passReg = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,20}$');

  String errorMessage = '';
  bool isStepTwo = false;

  late AnimationController controller;
  late Animation<Color?> animation = const AlwaysStoppedAnimation(Colors.green);

  @override
  void dispose() {
    name.dispose();
    age.dispose();
    email.dispose();
    password.dispose();
    verif.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    //start the controller
    controller = AnimationController(duration: Duration(milliseconds: 500), vsync: this);

    animation = ColorTween(
        begin: Colors.green,
        end: Colors.black54
    ).animate(controller)..addListener((){
      setState(() {});
    });
  }

  //changes the color of a specific range
  void animationColor(){
    if(controller.status == AnimationStatus.completed){
      controller.reverse();
    } else {
      controller.forward();
    }
  }

  bool inputFormatCheck(String? input, [RegExp? regex]){
    if(input == null || input.trim().isEmpty) {
      errorMessage = 'Provide a valid information in each field';
      return false;

    } else {
      if (regex != null && !regex.hasMatch(input.trim())) {
        errorMessage = 'Ensure the email is formatted as \"name@email.domain\"';
        return false;

      } else {
        return true;
      }
    }
  }

  Future<void> createUserAccount() async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      String uid = userCredential.user!.uid;

      try {
        await FirebaseFirestore.instance.collection("users").doc(uid).set({
          "username": name.text.trim(),
          "age": int.parse(age.text.trim()),
          "email": email.text.trim(),

          "cookieClicker": {
            "cookieCount": "0",
            "clickStrength": "1",
            "cookiesPerSecond": "0",
            "fallingCookiesReward": "10",
            "upgrades": {},
          },

          "flappyBird": {
            "highScore": 0,
          },

          "wordle": {
            "guessedWordsAmount": 0,
          },

          "createdAt": FieldValue.serverTimestamp(),
        });

        await userCredential.user!.sendEmailVerification();
      } catch (e) {
        await userCredential.user!.delete();
        rethrow;
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Account created. Check your email to verify your account."),
        ),
      );

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      String message = "Registration failed. Reason: ${e.message}";

      if (e.code == "email-already-in-use") {
        message = "This email is already being used.";
      } else if (e.code == "weak-password") {
        message = "This password is too weak.";
      } else if (e.code == "invalid-email") {
        message = "This email is invalid.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
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
            const Text('Create a Dopa-Miner Account',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.pinkAccent,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.green,
                    fontSize: 30
                )
            ),

            const SizedBox(height: 20),

            Image.asset('assets/dopaminerlogo.png'),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  IgnorePointer(
                    ignoring: isStepTwo,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: animation.value ?? Colors.green, width: 1),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                        child: Column(
                          children: [
                            TextField(
                              controller: name,
                              decoration: InputDecoration(
                                labelText: "Username",
                                labelStyle: TextStyle(color: animation.value),
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextField(
                              controller: age,
                              decoration: InputDecoration(
                                labelText: "Age",
                                labelStyle: TextStyle(color: animation.value),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: isStepTwo ? 1.0 : 0.0,
                    child: IgnorePointer(
                      ignoring: !isStepTwo,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 1),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                          child: Column(
                            children: [
                              TextField(
                                controller: email,
                                decoration: const InputDecoration(
                                  labelText: "Email",
                                  labelStyle: TextStyle(color: Colors.pinkAccent),
                                ),
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                controller: password,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if(!inputFormatCheck(value, passReg)){
                                    return """
  What\'s expected:
    - At least 1 lowercase letter
    - At least 1 uppercase letter
    - At least 1 number
    - Between 8 to 20 characters
    - No special characters
                                    """;
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                  labelText: "Password",
                                  labelStyle: TextStyle(color: Colors.pinkAccent),
                                ),
                              ),
                              const SizedBox(height: 5),
                              TextField(
                                controller: verif,
                                decoration: const InputDecoration(
                                  labelText: "Confirm password",
                                  labelStyle: TextStyle(color: Colors.pinkAccent),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent
                  ),
                  onPressed: (){
                    if(isStepTwo){
                      setState(() {
                        animationColor();
                        isStepTwo = !isStepTwo;
                      });
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Cancel',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40
                      )
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green
                  ),
                  onPressed: (){
                    if(!isStepTwo){
                      if(inputFormatCheck(name.text) && inputFormatCheck(age.text)){
                        if(int.tryParse(age.text) == null || int.tryParse(age.text)! <= 0){
                          ScaffoldMessenger.of(context).
                          showSnackBar(const SnackBar(content: Text('Provide an '
                              'age as a whole number greater than 0.')));
                        } else {
                          setState(() {
                            animationColor();
                            isStepTwo = !isStepTwo;
                          });
                        }
                      } else {
                        ScaffoldMessenger.of(context).
                        showSnackBar(const SnackBar(content: Text('Please provide'
                          'valid informations in each box')));
                      }
                    } else {
                      if(!inputFormatCheck(email.text, emailReg) || !inputFormatCheck(password.text, passReg)){
                        ScaffoldMessenger.of(context).
                        showSnackBar(const SnackBar(content: Text('Please provide'
                          'a valid information in each field')));
                      } else if (verif.text != password.text) {
                        ScaffoldMessenger.of(context).
                        showSnackBar(const SnackBar(content: Text('The two passwords do not match.')));
                      } else {
                        createUserAccount();
                      }
                    }
                  },
                  child: const Text('Register',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40
                      )
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}