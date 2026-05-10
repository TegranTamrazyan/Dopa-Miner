import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GameSave {
  static DocumentReference<Map<String, dynamic>>? get userDoc {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return null;

    return FirebaseFirestore.instance.collection("users").doc(user.uid);
  }

  static Future<Map<String, dynamic>?> loadUserData() async {
    final docRef = userDoc;

    if (docRef == null) return null;

    final doc = await docRef.get();

    if (!doc.exists) return null;

    return doc.data();
  }

  static Future<void> saveCookieClicker({
    required BigInt cookieCount,
    required BigInt clickStrength,
    required BigInt cookiesPerSecond,
    required BigInt fallingCookiesReward,
    required Map<String, int> upgrades,
  }) async {
    final docRef = userDoc;

    if (docRef == null) return;

    await docRef.update({
      "cookieClicker.cookieCount": cookieCount.toString(),
      "cookieClicker.clickStrength": clickStrength.toString(),
      "cookieClicker.cookiesPerSecond": cookiesPerSecond.toString(),
      "cookieClicker.fallingCookiesReward": fallingCookiesReward.toString(),
      "cookieClicker.upgrades": upgrades,
      "cookieClicker.lastSaved": FieldValue.serverTimestamp(),
    });
  }

  static Future<void> saveFlappyHighScore(int highScore) async {
    final docRef = userDoc;

    if (docRef == null) return;

    await docRef.update({
      "flappyBird.highScore": highScore,
    });
  }

  static Future<void> saveWordleGuessedWords(int guessedWordsAmount) async {
    final docRef = userDoc;

    if (docRef == null) return;

    await docRef.update({
      "wordle.guessedWordsAmount": guessedWordsAmount,
    });
  }
}