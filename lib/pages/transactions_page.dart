import 'package:expenz_app/models/expense_model.dart';
import 'package:expenz_app/models/income_model.dart';
import 'package:expenz_app/utils/colors.dart';
import 'package:expenz_app/utils/constants.dart';
import 'package:expenz_app/widgets/expense_card.dart';
import 'package:expenz_app/widgets/income_card.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  final List<Expense> expensesList;
  final List<Income> incomesList;
  final void Function(Expense) onDismissedExpense;
  final void Function(Income) onDismissedIncome;
  const TransactionScreen({
    super.key,
    required this.expensesList,
    required this.onDismissedExpense,
    required this.incomesList,
    required this.onDismissedIncome,
  });

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "See your Financial Report",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kMainColor,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Expenses",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kBlack,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: height * 0.3,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: widget.expensesList.length,
                          itemBuilder: (context, index) {
                            final expense = widget.expensesList[index];
                            return Dismissible(
                              key: ValueKey(expense),
                              direction: DismissDirection.startToEnd,
                              onDismissed: (direction) {
                                setState(() {
                                  widget.onDismissedExpense(expense);
                                });
                              },
                              child: ExpenseCard(
                                title: expense.title,
                                date: expense.date,
                                amount: expense.amount,
                                category: expense.category,
                                description: expense.description,
                                time: expense.time,
                              ),
                            );
                          })
                    ],
                  ),
                ),
              ),
              Text(
                "Incomes",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kBlack,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: height * 0.3,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: widget.incomesList.length,
                        itemBuilder: (context, index) {
                          final income = widget.incomesList[index];

                          return Dismissible(
                            key: ValueKey(income),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) {
                              setState(() {
                                widget.onDismissedIncome(income);
                              });
                            },
                            child: IncomeCard(
                              title: income.title,
                              date: income.date,
                              time: income.time,
                              amount: income.amount,
                              category: income.category,
                              description: income.description,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
