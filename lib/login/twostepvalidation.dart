import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dopaminer_new2/main/bottomnavmenu.dart';


class ValidatePage extends StatefulWidget {
  final String email;

  const ValidatePage({super.key, required this.email});

  @override
  State<ValidatePage> createState() => _ValidatePageState();
}

class _ValidatePageState extends State<ValidatePage> {
  bool isChecking = false;

  Future<void> resendVerificationEmail() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No user is currently logged in.")),
      );
      return;
    }

    try {
      await user.sendEmailVerification();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Verification email sent to ${widget.email}")),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.message}")),
      );
    }
  }

  Future<void> checkIfEmailVerified() async {
    setState(() {
      isChecking = true;
    });

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      setState(() {
        isChecking = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No user is currently logged in.")),
      );
      return;
    }

    await user.reload();

    final refreshedUser = FirebaseAuth.instance.currentUser;

    setState(() {
      isChecking = false;
    });

    if (refreshedUser != null && refreshedUser.emailVerified) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email verified!")),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GamePage(
            //email: email.text.trim(),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email is not verified yet. Check your inbox.")),
      );
    }
  }

  Future<void> cancelAndSignOut() async {
    await FirebaseAuth.instance.signOut();

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          children: [
            const SizedBox(height: 60),
            const Text(
              'Please Confirm\nyour email',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.pinkAccent,
                decoration: TextDecoration.underline,
                decorationColor: Colors.green,
                fontSize: 45,
              ),
            ),

            const SizedBox(height: 20),

            Image.asset('assets/dopaminerlogo.png'),

            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
              child: Column(
                children: [
                  Text(
                    "A verification link was sent to:\n${widget.email}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Open your email, click the verification link, then come back and press I Verified.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextButton(
                    onPressed: resendVerificationEmail,
                    child: const Text(
                      'Re-send verification email',
                      style: TextStyle(
                        color: Colors.indigo,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.indigo,
                        fontSize: 20,
                      ),
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
                    backgroundColor: Colors.pinkAccent,
                  ),
                  onPressed: cancelAndSignOut,
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: isChecking ? null : checkIfEmailVerified,
                  child: Text(
                    isChecking ? 'Checking...' : 'I Verified',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
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