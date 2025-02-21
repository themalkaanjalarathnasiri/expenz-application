import 'package:expenz_app/pages/Onboarding/onboarding_pages.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance;
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
