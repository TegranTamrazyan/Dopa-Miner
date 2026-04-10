import 'package:flutter/material.dart';

class wordlePage extends StatefulWidget {
  const wordlePage({super.key});

  @override
  State<wordlePage> createState() => _wordlePageState();
}

class _wordlePageState extends State<wordlePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("wordle"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("hiiii")
          ],
        ),
      ),
    );
  }
}