import 'package:expenz_app/pages/Onboarding/onboarding_pages.dart';
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
      home: OnboardingScreen(),
    );
  }
}
