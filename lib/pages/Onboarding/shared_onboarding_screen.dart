import 'package:expenz_app/utils/colors.dart';
import 'package:expenz_app/utils/constants.dart';
import 'package:flutter/material.dart';

class SharedOnboardingScreen extends StatelessWidget {
  final String title;
  final String imagePath;
  final String description;
  const SharedOnboardingScreen({
    super.key,
    required this.title,
    required this.imagePath,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 300,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            description,
            style: const TextStyle(
              color: kGrey,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
