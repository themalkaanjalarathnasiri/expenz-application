import 'package:expenz_app/models/expense_model.dart';
import 'package:expenz_app/models/income_model.dart';
import 'package:expenz_app/utils/colors.dart';
import 'package:expenz_app/utils/constants.dart';
import 'package:expenz_app/services/user_services.dart';
import 'package:expenz_app/widgets/expense_card.dart';
import 'package:expenz_app/widgets/income_expense_card.dart';
import 'package:expenz_app/widgets/line_chart.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final List<Expense> expensesList;
  final List<Income> incomesList;
  const HomeScreen(
      {super.key, required this.expensesList, required this.incomesList});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // For Store the Username
  String username = "";
  double expenseTotal = 0;
  double incomeTotal = 0;
  @override
  void initState() {
    // Get the Username
    UserServices.getUserData().then(
      (value) {
        if (value["username"] != null) {
          setState(
            () {
              username = value["username"]!;
            },
          );
        }
      },
    );
    setState(() {
      for (var i = 0; i < widget.expensesList.length; i++) {
        expenseTotal += widget.expensesList[i].amount;
      }

      for (var k = 0; k < widget.incomesList.length; k++) {
        incomeTotal += widget.incomesList[k].amount;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: BoxDecoration(
                    color: kMainColor.withOpacity(0.2),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    )),
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
                                )),
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
                          Text(
                            "Welcome $username",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications,
                              color: kMainColor,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IncomeExpenseCard(
                            bgColor: kGreen,
                            title: "Income",
                            amount: incomeTotal,
                            image: "assets/images/income.png",
                          ),
                          IncomeExpenseCard(
                            bgColor: kRed,
                            title: "Expense",
                            amount: expenseTotal,
                            image: "assets/images/expense.png",
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Spend Frequency",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    LineChartSample()
                  ],
                ),
              ),
              // Recent Transactions
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Recent Transactions",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        widget.expensesList.isEmpty
                            ? Text(
                                "No Expenses Added yet, add some expenses to see here",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: kGrey,
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.expensesList.length,
                                itemBuilder: (context, index) {
                                  final expense = widget.expensesList[index];
                                  return ExpenseCard(
                                    title: expense.title,
                                    date: expense.date,
                                    amount: expense.amount,
                                    category: expense.category,
                                    description: expense.description,
                                    time: expense.time,
                                  );
                                })
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
