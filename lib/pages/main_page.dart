import 'package:expenz_app/models/expense_model.dart';
import 'package:expenz_app/models/income_model.dart';
import 'package:expenz_app/services/expense_service.dart';
import 'package:expenz_app/services/income_service.dart';
import 'package:expenz_app/utils/colors.dart';
import 'package:expenz_app/pages/add_new_page.dart';
import 'package:expenz_app/pages/budget_page.dart';
import 'package:expenz_app/pages/home_page.dart';
import 'package:expenz_app/pages/profile_page.dart';
import 'package:expenz_app/pages/transactions_page.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPageIndex = 0;

  List<Expense> expenseList = [];
  List<Income> incomeList = [];

  // Fetch Expenses
  void fetchAllExpenses() async {
    List<Expense> loadedExpenses = await ExpenseService().loadExpenses();
    setState(() {
      expenseList = loadedExpenses;
      print(expenseList.length);
    });
  }

  // Fetch Incomes
  void fetchAllIncomes() async {
    List<Income> loadedIncomes = await IncomeService().loadIncomes();
    setState(() {
      incomeList = loadedIncomes;
      print(incomeList.length);
    });
  }

  // Add New Expense
  void addNewExpense(Expense newExpense) {
    ExpenseService().saveExpenses(newExpense, context);

    // Update Expense List
    setState(() {
      expenseList.add(newExpense);
    });
  }

  // Add new incomes
  void addNewIncome(Income newIncome) {
    IncomeService().saveIncomes(newIncome, context);

    // Update Income List
    setState(() {
      incomeList.add(newIncome);
    });
  }

  // Function to Remove a Expense
  void removeExpense(Expense expense) {
    ExpenseService().deleteExpenses(expense.id, context);
    setState(() {
      expenseList.remove(expense);
    });
  }

  // Function to Remove a Income
  void removeIncome(Income income) {
    IncomeService().deleteIncomes(income.id, context);
    setState(() {
      incomeList.remove(income);
    });
  }

  // Category Total Expenses
  Map<ExpenseCategory, double> calculateExpenseCategories() {
    Map<ExpenseCategory, double> categoryTotal = {
      ExpenseCategory.food: 0,
      ExpenseCategory.health: 0,
      ExpenseCategory.shopping: 0,
      ExpenseCategory.subscription: 0,
      ExpenseCategory.transport: 0,
    };
    for (Expense expense in expenseList) {
      categoryTotal[expense.category] =
          categoryTotal[expense.category]! + expense.amount;
    }
    return categoryTotal;
  }

  // Category Total Incomes
  Map<IncomeCategory, double> calculateIncomeCategories() {
    Map<IncomeCategory, double> categoryTotal = {
      IncomeCategory.freelance: 0,
      IncomeCategory.passive: 0,
      IncomeCategory.salary: 0,
      IncomeCategory.sales: 0,
    };
    for (Income income in incomeList) {
      categoryTotal[income.category] =
          categoryTotal[income.category]! + income.amount;
    }
    return categoryTotal;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      fetchAllExpenses();
      fetchAllIncomes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(
        expensesList: expenseList,
        incomesList: incomeList,
      ),
      TransactionScreen(
        expensesList: expenseList,
        incomesList: incomeList,
        onDismissedExpense: removeExpense,
        onDismissedIncome: removeIncome,
      ),
      AddNewScreen(
        addExpense: addNewExpense,
        addIncome: addNewIncome,
      ),
      BudgetScreen(
        expenseCategoryTotal: calculateExpenseCategories(),
        incomeCategoryTotal: calculateIncomeCategories(),
      ),
      ProfileScreen(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kWhite,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGrey,
        currentIndex: _currentPageIndex,
        onTap: (value) {
          setState(() {
            _currentPageIndex = value;
          });
        },
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: "Transaction",
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: kMainColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                color: kWhite,
                size: 30,
              ),
            ),
            label: "",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.rocket),
            label: "Budget",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
      body: pages[_currentPageIndex],
    );
  }
}
