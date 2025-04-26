import 'package:expenz_app/models/expense_model.dart';
import 'package:expenz_app/models/income_model.dart';
import 'package:expenz_app/utils/colors.dart';
import 'package:expenz_app/utils/constants.dart';
import 'package:expenz_app/widgets/category_card.dart';
import 'package:expenz_app/widgets/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BudgetScreen extends StatefulWidget {
  final Map<ExpenseCategory, double> expenseCategoryTotal;
  final Map<IncomeCategory, double> incomeCategoryTotal;
  const BudgetScreen(
      {super.key,
      required this.expenseCategoryTotal,
      required this.incomeCategoryTotal});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  int _selectedOption = 0;

  // Category Color Method
  Color getCategoryColor(dynamic category) {
    if (category is ExpenseCategory) {
      return expenseCategoryColors[category]!;
    } else {
      return incomeCategoryColors[category]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = _selectedOption == 0
        ? widget.expenseCategoryTotal
        : widget.incomeCategoryTotal;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Financial Report",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: kBlack,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding / 2,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: kBlack.withOpacity(0.1),
                          blurRadius: 20,
                        ),
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedOption = 0;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: _selectedOption == 1 ? kWhite : kRed,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 55),
                            child: Text(
                              "Expense",
                              style: TextStyle(
                                color: _selectedOption == 0 ? kWhite : kBlack,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedOption = 1;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: _selectedOption == 0 ? kWhite : kGreen,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 55),
                            child: Text(
                              "Income",
                              style: TextStyle(
                                color: _selectedOption == 1 ? kWhite : kBlack,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Pie Chart
              Chart(
                expenseCategoryTotal: widget.expenseCategoryTotal,
                incomeCategoryTotal: widget.incomeCategoryTotal,
                isExpense: _selectedOption == 0,
              ),
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final category = data.keys.toList()[index];
                  final total = data.values.toList()[index];
                  return CategoryCard(
                    title: category.name,
                    amount: total,
                    total:
                        data.values.reduce((value, element) => value + element),
                    progressColor: getCategoryColor(category),
                    isExpense: _selectedOption == 0,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
