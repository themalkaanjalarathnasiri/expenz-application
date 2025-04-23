import 'dart:convert';

import 'package:expenz_app/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseService {
  // Expense List
  List<Expense> expensesList = [];

  // Expense Key
  static const String _expenseKey = 'expenses';

  // Save the Expenses
  Future<void> saveExpenses(Expense expense, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingExpenses = prefs.getStringList(_expenseKey);

      // Convert to Expense Objects
      List<Expense> existingExpenseObjects = [];
      if (existingExpenses != null) {
        existingExpenseObjects = existingExpenses
            .map((e) => Expense.fromJSON(json.decode(e)))
            .toList();
      }

      // Add New Expenses to the List
      existingExpenseObjects.add(expense);

      // Expense objects to a list
      List<String> updatedExpense =
          existingExpenseObjects.map((e) => json.encode(e.toJSON())).toList();

      // Storing in Shared Preferences
      await prefs.setStringList(_expenseKey, updatedExpense);

      // Show Message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Expense Added Successfully!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      // Show Message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error on Adding an Expense..."),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  // Load the Expenses from Shared Preferences
  Future<List<Expense>> loadExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? existingExpenses = prefs.getStringList(_expenseKey);

    // Existing Expenses to Expenses Objects List
    List<Expense> loadedExpenses = [];
    if (existingExpenses != null) {
      loadedExpenses = existingExpenses
          .map((e) => Expense.fromJSON(json.decode(e)))
          .toList();
    }
    return loadedExpenses;
  }

  // Delete Expenses fromShared Preferences
  Future<void> deleteExpenses(int id, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingExpense = prefs.getStringList(_expenseKey);

      //List to Expense Objects
      List<Expense> existingExpenseObjects = [];
      if (existingExpense != null) {
        existingExpenseObjects = existingExpense
            .map((e) => Expense.fromJSON(json.decode(e)))
            .toList();
      }

      // Remove Expenses witht he Specified ID
      existingExpenseObjects.removeWhere((expense) => expense.id == id);

      // Objects to Expense List
      List<String> updatedExpenses =
          existingExpenseObjects.map((e) => json.encode(e.toJSON())).toList();

      // Save Updated List in S.P
      await prefs.setStringList(_expenseKey, updatedExpenses);

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
}
