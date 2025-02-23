import 'package:expenz_app/pages/Onboarding/onboarding_pages.dart';
import 'package:expenz_app/pages/main_page.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  final bool showMainScreen;
  const Wrapper({super.key, required this.showMainScreen});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return widget.showMainScreen ? MainScreen() : OnboardingScreen();
  }
}
