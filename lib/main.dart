import 'package:expenz_app/pages/Onboarding/onboarding_pages.dart';
import 'package:expenz_app/services/user_services.dart';
import 'package:expenz_app/widgets/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance;
  runApp(const ExpenzApp());
}

class ExpenzApp extends StatelessWidget {
  const ExpenzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserServices.checkUsername(),
      builder: (context, snapshot) {
        // Still Waiting
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          // hasUserName will be set to True if Data is in the snapshot
          bool hasUserName = snapshot.data ?? false;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: "Inter",
            ),
            home: Wrapper(
              showMainScreen: hasUserName,
            ),
          );
        }
      },
    );
  }
}
