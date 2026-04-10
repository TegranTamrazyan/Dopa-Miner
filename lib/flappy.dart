import 'package:flutter/material.dart';

class flappyPage extends StatefulWidget {
  const flappyPage({super.key});

  @override
  State<flappyPage> createState() => _flappyPageState();
}

class _flappyPageState extends State<flappyPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("flappy bird"),
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