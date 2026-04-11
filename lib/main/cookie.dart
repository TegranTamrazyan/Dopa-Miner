import 'package:flutter/material.dart';

class cookiePage extends StatefulWidget {
  const cookiePage({super.key});

  @override
  State<cookiePage> createState() => _cookiePageState();
}

class _cookiePageState extends State<cookiePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("cookie clicker"),
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