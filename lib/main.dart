import 'package:flutter/material.dart';

void main() {
  runApp(const ExpenzApp());
}

class ExpenzApp extends StatelessWidget {
  const ExpenzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Expenz",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Inter",
        ),
        home: Scaffold(
          body: Center(
            child: Text(
              "Hello Flutter",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ));
  }
}
