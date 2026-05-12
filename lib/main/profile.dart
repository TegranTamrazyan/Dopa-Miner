import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dopaminer_new2/login/login.dart';


class profilePage extends StatefulWidget {
  const profilePage({super.key});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  String username = "";
  String email = "";
  int age = 0;
  String cookieCount = "0";
  int flappyHighScore = 0;
  int guessedWordsAmount = 0;

  Timer? refresh;

  @override
  void initState() {
    super.initState();

    loadProfile();

    refresh = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (!mounted) return;

      loadProfile();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                logout();
              },
              icon: const Icon(Icons.reset_tv)
          )
        ],
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 30, bottom: 35),
              decoration: const BoxDecoration(
                color: Colors.pinkAccent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Text(
                    username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    email,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  buildInfoCard(
                    icon: Icons.cookie,
                    title: "Cookie Clicker",
                    subtitle: "Cookies: ${displayCookieInMoneyFormat(BigInt.parse(cookieCount))}",
                    color: Colors.orangeAccent,
                  ),
                  buildInfoCard(
                    icon: Icons.flight,
                    title: "Flappy Bird",
                    subtitle: "High Score: $flappyHighScore",
                    color: Colors.lightBlueAccent,
                  ),
                  buildInfoCard(
                    icon: Icons.text_fields,
                    title: "Wordle",
                    subtitle: "Words Guessed: $guessedWordsAmount",
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: color.withOpacity(0.2),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),

          const SizedBox(width: 15),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Future<void> loadProfile() async{
    final user = FirebaseAuth.instance.currentUser!;
    final uid = user.uid;

    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get();

    final data = doc.data()!;

    setState(() {
      username = data["username"] ?? "";
      email = data["email"] ?? "";
      age = data["age"] ?? 0;

      cookieCount = data["cookieClicker"]?["cookieCount"] ?? "0";
      flappyHighScore = data["flappyBird"]?["highScore"] ?? 0;
      guessedWordsAmount = data["wordle"]?["guessedWordsAmount"] ?? 0;
    });
  }

  String displayCookieInMoneyFormat(BigInt cookiesAmount) {
    double cookiesText = 0;
    var formatter = NumberFormat('#,###.##');

    if (cookiesAmount > BigInt.from(1000) && cookiesAmount < BigInt.from(1000000)) {
      cookiesText = cookiesAmount / BigInt.from(1000);
      return '${formatter.format(cookiesText)} K';
    }
    else if (cookiesAmount > BigInt.from(1000000) && cookiesAmount < BigInt.from(1000000000)) {
      cookiesText = cookiesAmount / BigInt.from(1000000);
      return '${formatter.format(cookiesText)} M';
    }
    else if (cookiesAmount > BigInt.from(1000000000) && cookiesAmount < BigInt.from(1000000000000)) {
      cookiesText = cookiesAmount / BigInt.from(1000000000);
      return '${formatter.format(cookiesText)} B';
    }

    else if (cookiesAmount > BigInt.from(1000000000000) && cookiesAmount < BigInt.from(1000000000000000)) {
      cookiesText = cookiesAmount / BigInt.from(1000000000000);
      return '${formatter.format(cookiesText)} T';
    }
    else if (cookiesAmount > BigInt.from(1000000000000000) && cookiesAmount < BigInt.from(1000000000000000000)) {
      cookiesText = cookiesAmount / BigInt.from(1000000000000000);
      return '${formatter.format(cookiesText)} q';
    }
    else if (cookiesAmount > BigInt.from(1000000000000000000) && cookiesAmount < BigInt.parse("1000000000000000000000")) {
      cookiesText = cookiesAmount / BigInt.from(1000000000000000000);
      return '${formatter.format(cookiesText)} Q';
    }

    return "$cookiesAmount";
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
          (route) => false,
    );
  }
}