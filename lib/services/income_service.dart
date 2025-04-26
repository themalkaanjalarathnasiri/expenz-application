import 'dart:convert';

import 'package:expenz_app/models/income_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeService {
  // Income List
  List<Income> incomeList = [];

  // Create Income Key
  static const String _incomeKey = 'incomes';

  // Save the Incomes
  Future<void> saveIncomes(Income income, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingIncomes = prefs.getStringList(_incomeKey);

      // Convert to Objects
      List<Income> existingIncomeObjects = [];
      if (existingIncomes != null) {
        existingIncomeObjects = existingIncomes
            .map((e) => Income.fromJSON(json.decode(e)))
            .toList();
      }

      // Add to the List
      existingIncomeObjects.add(income);

      // Income Objects to a List
      List<String> updatedIncome =
          existingIncomeObjects.map((e) => json.encode(e.toJSON())).toList();

      // Storing in Shared Prefs
      await prefs.setStringList(_incomeKey, updatedIncome);

      // Show Message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Income Added Successfully!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error on Adding an Income..."),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<List<Income>> loadIncomes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? existingIncomes = prefs.getStringList(_incomeKey);

    // Convert to Object List
    List<Income> loadedIncomes = [];
    if (existingIncomes != null) {
      loadedIncomes =
          existingIncomes.map((e) => Income.fromJSON(json.decode(e))).toList();
    }
    return loadedIncomes;
  }

  // Delete Expenses fromShared Preferences
  Future<void> deleteIncomes(int id, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingExpense = prefs.getStringList(_incomeKey);

      //List to Expense Objects
      List<Income> existingExpenseObjects = [];
      if (existingExpense != null) {
        existingExpenseObjects = existingExpense
            .map((e) => Income.fromJSON(json.decode(e)))
            .toList();
      }

      // Remove Expenses witht he Specified ID
      existingExpenseObjects.removeWhere((expense) => expense.id == id);

      // Objects to Expense List
      List<String> updatedExpenses =
          existingExpenseObjects.map((e) => json.encode(e.toJSON())).toList();

      // Save Updated List in S.P
      await prefs.setStringList(_incomeKey, updatedExpenses);

      // Show Message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Expense Deleted Successfuly"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      print(error.toString());
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error Deleting Expense"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  // Delete all Incomes from Shared Preferences
  Future<void> deleteAllIncomes(BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.remove(_incomeKey);

      // Show Message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("All Incomes Deleted"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      // Show Message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error Deleting Incomes"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
