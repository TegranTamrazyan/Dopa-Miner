import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class leaderboardPage extends StatefulWidget {
  const leaderboardPage({super.key});

  @override
  State<leaderboardPage> createState() => _leaderboardPageState();
}


class _leaderboardPageState extends State<leaderboardPage> {

  late Future<List<Map<String, dynamic>>> cookieLeaderboardFuture;
  late Future<List<Map<String, dynamic>>> flappyLeaderboardFuture;
  late Future<List<Map<String, dynamic>>> wordleLeaderboardFuture;

  @override
  void initState() {
    super.initState();
    refreshLeaderboards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text("Leaderboards", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),),
          ],
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<Map<String, dynamic>>>(
              future: cookieLeaderboardFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return buildLeaderboardSection(
                    title: "Cookie Clicker Leaderboard",
                    firstName: "No user",
                    firstScore: "0",
                    secondName: "No user",
                    secondScore: "0",
                    thirdName: "No user",
                    thirdScore: "0",
                  );
                }

                final users = snapshot.data!;

                return buildLeaderboardSection(
                  title: "Cookie Clicker Leaderboard",
                  firstName: getUserName(users, 0),
                  firstScore: "${getCookieScore(users, 0)} Cookies",
                  secondName: getUserName(users, 1),
                  secondScore: "${getCookieScore(users, 1)} Cookies",
                  thirdName: getUserName(users, 2),
                  thirdScore: "${getCookieScore(users, 2)} Cookies",
                );
              },
            ),

            FutureBuilder<List<Map<String, dynamic>>>(
              future: flappyLeaderboardFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return buildLeaderboardSection(
                    title: "Flappy Bird Leaderboard",
                    firstName: "No user",
                    firstScore: "0",
                    secondName: "No user",
                    secondScore: "0",
                    thirdName: "No user",
                    thirdScore: "0",
                  );
                }

                final users = snapshot.data!;

                return buildLeaderboardSection(
                  title: "Flappy Bird Leaderboard",
                  firstName: getUserName(users, 0),
                  firstScore: "Score: ${getFlappyScore(users, 0)}",
                  secondName: getUserName(users, 1),
                  secondScore: "Score: ${getFlappyScore(users, 1)}",
                  thirdName: getUserName(users, 2),
                  thirdScore: "Score: ${getFlappyScore(users, 2)}",
                );
              },
            ),

            FutureBuilder<List<Map<String, dynamic>>>(
              future: wordleLeaderboardFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return buildLeaderboardSection(
                    title: "Wordle Leaderboard",
                    firstName: "No user",
                    firstScore: "0",
                    secondName: "No user",
                    secondScore: "0",
                    thirdName: "No user",
                    thirdScore: "0",
                  );
                }

                final users = snapshot.data!;

                return buildLeaderboardSection(
                  title: "Wordle Leaderboard",
                  firstName: getUserName(users, 0),
                  firstScore: "${getWordleScore(users, 0)} Words",
                  secondName: getUserName(users, 1),
                  secondScore: "${getWordleScore(users, 1)} Words",
                  thirdName: getUserName(users, 2),
                  thirdScore: "${getWordleScore(users, 2)} Words",
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.fromLTRB(0,0,0,50)),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      refreshLeaderboards();
                    });
                  },
                  child: const Row(
                    children: [
                      Text("Refresh Leaderboard"),
                      Icon(Icons.refresh, color: Colors.black),
                    ],
                  ),
                )

              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildLeaderboardSection({
    required String title,
    required String firstName,
    required String firstScore,
    required String secondName,
    required String secondScore,
    required String thirdName,
    required String thirdScore,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
              ),
            ),

            const SizedBox(height: 25),

            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildPodiumPlace(
                  place: "2nd",
                  name: secondName,
                  score: secondScore,
                  color: Colors.grey,
                  height: 140,
                ),

                const SizedBox(width: 10),

                buildPodiumPlace(
                  place: "1st",
                  name: firstName,
                  score: firstScore,
                  color: Colors.amber,
                  height: 180,
                ),

                const SizedBox(width: 10),

                buildPodiumPlace(
                  place: "3rd",
                  name: thirdName,
                  score: thirdScore,
                  color: Colors.brown,
                  height: 110,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPodiumPlace({
    required String place,
    required String name,
    required String score,
    required Color color,
    required double height,
  }) {
    return Column(
      children: [
        Text(
          place,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),

        const SizedBox(height: 5),

        Container(
          width: 95,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  score,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<List<Map<String, dynamic>>> getCookieClickerTopCookieCounts() async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .orderBy("cookieClicker.cookieCount", descending: true)
        .limit(3)
        .get();

    return querySnapshot.docs.map((doc){
      return doc.data() as Map<String, dynamic>;
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getFlappyBirdTopScores() async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .orderBy("flappyBird.highScore", descending: true)
        .limit(3)
        .get();

    return querySnapshot.docs.map((doc){
      return doc.data() as Map<String, dynamic>;
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getWordleHighestAmountOfGuesses() async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .orderBy("wordle.guessedWordsAmount", descending: true)
        .limit(3)
        .get();

    return querySnapshot.docs.map((doc){
      return doc.data() as Map<String, dynamic>;
    }).toList();
  }

  String getUserName(List<Map<String, dynamic>> users, int index) {
    if (users.length <= index) return "No user";

    return users[index]["username"] ?? "Unknown";
  }

  String getCookieScore(List<Map<String, dynamic>> users, int index) {
    if (users.length <= index) return "0";

    final cookieClicker = users[index]["cookieClicker"] ?? {};
    return displayCookieInMoneyFormat(BigInt.parse(cookieClicker["cookieCount"])) ?? "0";
  }

  int getFlappyScore(List<Map<String, dynamic>> users, int index) {
    if (users.length <= index) return 0;

    final flappyBird = users[index]["flappyBird"] ?? {};
    return flappyBird["highScore"] ?? 0;
  }

  int getWordleScore(List<Map<String, dynamic>> users, int index) {
    if (users.length <= index) return 0;

    final wordle = users[index]["wordle"] ?? {};
    return wordle["guessedWordsAmount"] ?? 0;
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

  void refreshLeaderboards() {
    cookieLeaderboardFuture = getCookieClickerTopCookieCounts();
    flappyLeaderboardFuture = getFlappyBirdTopScores();
    wordleLeaderboardFuture = getWordleHighestAmountOfGuesses();
  }
}