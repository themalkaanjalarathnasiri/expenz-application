import 'package:expenz_app/pages/Onboarding/onboarding_pages.dart';
import 'package:expenz_app/services/expense_service.dart';
import 'package:expenz_app/services/income_service.dart';
import 'package:expenz_app/services/user_services.dart';
import 'package:expenz_app/utils/colors.dart';
import 'package:expenz_app/utils/constants.dart';
import 'package:expenz_app/widgets/profile_card.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = "";
  String email = "";
  @override
  void initState() {
    UserServices.getUserData().then((value) {
      if (value['username'] != null && value['email'] != null) {
        setState(() {
          username = value['username']!;
          email = value['email']!;
        });
      }
    });
    super.initState();
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: kGrey.withOpacity(0.6),
        context: context,
        builder: (context) {
          return Container(
            height: 200,
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Are you Sure you want to log out?",
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          kRed.withOpacity(0.8),
                        ),
                      ),
                      onPressed: () async {
                        // Clear User Data
                        await UserServices.clearUserData();
                        if (context.mounted) {
                          // Clear Expenses
                          await ExpenseService().deleteAllExpenses(context);
                          //Clear Incomes
                          await IncomeService().deleteAllIncomes(context);
                          // Navigate to Onborading Screen
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OnboardingScreen(),
                            ),
                            (route) => false,
                          );
                        }
                      },
                      child: Text(
                        "Yes",
                        style: TextStyle(
                          color: kWhite,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          kGreen.withOpacity(0.8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "No",
                        style: TextStyle(
                          color: kWhite,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: kMainColor,
                        border: Border.all(
                          color: kMainColor,
                          width: 3,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          "assets/images/user.jpg",
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome $username",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "$email",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                          color: kMainColor,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                ProfileCard(
                  icon: Icons.wallet,
                  title: "My Wallet",
                  color: kMainColor,
                ),
                ProfileCard(
                  icon: Icons.settings,
                  title: "Settings",
                  color: kYellow,
                ),
                ProfileCard(
                  icon: Icons.download,
                  title: "Export Data",
                  color: kGreen,
                ),
                GestureDetector(
                  onTap: () {
                    _showBottomSheet(context);
                  },
                  child: ProfileCard(
                    icon: Icons.logout,
                    title: "Log Out",
                    color: kRed,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
