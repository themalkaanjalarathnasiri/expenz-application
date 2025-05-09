import 'package:expenz_app/utils/colors.dart';
import 'package:expenz_app/data/onboarding_data.dart';
import 'package:expenz_app/pages/Onboarding/front_page.dart';
import 'package:expenz_app/pages/Onboarding/shared_onboarding_screen.dart';
import 'package:expenz_app/pages/user_data_page.dart';
import 'package:expenz_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Page Controller
  final PageController _controller = PageController();

  bool showDetailsPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                // Onboarding Screens
                PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      showDetailsPage = index == 3;
                    });
                  },
                  children: [
                    const FrontPage(),
                    SharedOnboardingScreen(
                      title: OnboardingData.onboardngDataList[0].title,
                      imagePath: OnboardingData.onboardngDataList[0].imagePath,
                      description:
                          OnboardingData.onboardngDataList[0].description,
                    ),
                    SharedOnboardingScreen(
                      title: OnboardingData.onboardngDataList[1].title,
                      imagePath: OnboardingData.onboardngDataList[1].imagePath,
                      description:
                          OnboardingData.onboardngDataList[1].description,
                    ),
                    SharedOnboardingScreen(
                      title: OnboardingData.onboardngDataList[2].title,
                      imagePath: OnboardingData.onboardngDataList[2].imagePath,
                      description:
                          OnboardingData.onboardngDataList[2].description,
                    ),
                  ],
                ),
                // Page Dot Indicator

                Container(
                  alignment: const Alignment(0, 0.68),
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 4,
                    effect: const WormEffect(
                      activeDotColor: kMainColor,
                      dotColor: kLightGrey,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: !showDetailsPage
                        ? GestureDetector(
                            onTap: () {
                              _controller.animateToPage(
                                _controller.page!.toInt() + 1,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: CustomButton(
                              buttonName:
                                  !showDetailsPage ? "Next" : "Get Started",
                              buttonColor: kMainColor,
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const UserDataScreen(),
                                ),
                              );
                            },
                            child: CustomButton(
                              buttonName:
                                  !showDetailsPage ? "Next" : "Get Started",
                              buttonColor: kMainColor,
                            ),
                          ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
