import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  // Method to Store Details
  static Future<void> storeUserDetails({
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    try {
      // Check Whether Passwords Match
      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Passwords do not match."),
          ),
        );
        return;
      }
      // Create an Instance for Shared Preference
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Store Username and Email
      await prefs.setString("username", userName);
      await prefs.setString("email", email);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("User Login Successfull"),
        ),
      );
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error storing user details: ${err.toString()}"),
        ),
      );
    }
  }

  // Method to check whether the Username is Saved
  static Future<bool> checkUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('username');
    return userName != null;
  }

  // Method to return Username and Email
  static Future<Map<String, String>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString("username");
    String? email = prefs.getString("email");
    return {"username": userName!, "email": email!};
  }
}
