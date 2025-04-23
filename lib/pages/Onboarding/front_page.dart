import 'package:expenz_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          "assets/animation/Animation - 1739968322676.json",
          height: 170,
          width: 200,
          fit: BoxFit.cover,
        ),
        const Center(
          child: Text(
            "Expenz",
            style: TextStyle(
              color: kBlack,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
