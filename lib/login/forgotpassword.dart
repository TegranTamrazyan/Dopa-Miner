import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  TextEditingController email = TextEditingController();

  TextEditingController newPass = TextEditingController();
  TextEditingController rePass = TextEditingController();

  RegExp passReg = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,20}$');
  String errorMessage = '';
  bool isStepTwo = false;

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

  Future<void> resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Password reset email sent. Check your inbox.",
          ),
        ),
      );

    } on FirebaseAuthException catch (e) {

      errorMessage = "Something went wrong.";

      if (e.code == "user-not-found") {
        errorMessage = "No account exists with this email.";
      } else if (e.code == "invalid-email") {
        errorMessage = "Invalid email.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
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
            const SizedBox(height: 60),
            const Text('Password Recovery',
                style: TextStyle(
                    color: Colors.pinkAccent,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.green,
                    fontSize: 45
                )
            ),

            const SizedBox(height: 20),

            Image.asset('assets/dopaminerlogo.png'),

            Padding(padding: EdgeInsets.only(left: 50, right: 50, top: 10),
              child: Column(
                children: [
                  TextField(
                    controller: email,
                    decoration: const InputDecoration(
                        labelText: "Your email",
                        labelStyle: TextStyle(
                          color: Colors.green,
                        )
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextButton(
                    onPressed: (){
                      resetPassword();

                      // setState(() {
                      //   //animationColor();
                      //   isStepTwo = !isStepTwo;
                      // });
                    },
                    style: TextButton.styleFrom(
                      overlayColor: Colors.transparent,
                    ),
                    child: const Text(
                        'Reset password',
                        style: TextStyle(
                            color: Colors.indigo,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.indigo,
                            fontSize: 20
                        )
                    ),
                  ),

//                   const SizedBox(height: 5),
//
//                   AnimatedOpacity(
//                     duration: const Duration(milliseconds: 500),
//                     opacity: isStepTwo ? 1.0 : 0.0,
//                     child: IgnorePointer(
//                       ignoring: !isStepTwo,
//                       child: Container(
//                         child: Column(
//                           children: [
//                             TextFormField(
//                               controller: newPass,
//                               autovalidateMode: AutovalidateMode.onUserInteraction,
//                               validator: (value) {
//                                 if(!inputFormatCheck(value, passReg)){
//                                   return """
// What\'s expected:
//   - At least 1 lowercase letter
//   - At least 1 uppercase letter
//   - At least 1 number
//   - Between 8 to 20 characters
//   - No special characters
// """;
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                               decoration: const InputDecoration(
//                                 labelText: "Your new password",
//                                 labelStyle: TextStyle(color: Colors.pinkAccent),
//                               ),
//                             ),
//                             const SizedBox(height: 15),
//                             TextField(
//                               controller: rePass,
//                               decoration: const InputDecoration(
//                                 labelText: "Re-enter the new password",
//                                 labelStyle: TextStyle(color: Colors.pinkAccent),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                   ),
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
                          fontSize: 40
                      )
                  ),
                ),
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.green
                //   ),
                //   onPressed: (){
                //     if(inputFormatCheck(newPass.text, passReg)){
                //       ScaffoldMessenger.of(context).
                //       showSnackBar(const SnackBar(content: Text('Please enter a '
                //         'valid password')));
                //     } else if (rePass.text != newPass.text) {
                //       ScaffoldMessenger.of(context).
                //       showSnackBar(const SnackBar(content: Text('The two passwords '
                //           'do not match.')));
                //     } else {
                //       Navigator.pop(context);
                //     }
                //   },
                //   child: const Text('Confirm',
                //       style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 30
                //       )
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}