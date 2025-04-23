import 'package:expenz_app/models/expense_model.dart';
import 'package:expenz_app/models/income_model.dart';
import 'package:expenz_app/services/expense_service.dart';
import 'package:expenz_app/services/income_service.dart';
import 'package:expenz_app/utils/colors.dart';
import 'package:expenz_app/utils/constants.dart';
import 'package:expenz_app/widgets/custom_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewScreen extends StatefulWidget {
  final Function(Expense) addExpense;
  final Function(Income) addIncome;
  const AddNewScreen(
      {super.key, required this.addExpense, required this.addIncome});

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  // State to track the Expense or Income
  int _selectedMethod = 0;
  ExpenseCategory _expensecategory = ExpenseCategory.health;
  IncomeCategory _incomeCategory = IncomeCategory.salary;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  DateTime _selectedTime = DateTime.now();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: _selectedMethod == 0 ? kRed : kGreen,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: kDefaultPadding,
                    horizontal: kDefaultPadding,
                  ),
                  child: Container(
                    height: height * 0.07,
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMethod = 0;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _selectedMethod == 0 ? kRed : kWhite,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 10,
                              ),
                              child: Text(
                                "Expense",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: _selectedMethod == 0 ? kWhite : kBlack,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMethod = 1;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _selectedMethod == 1 ? kGreen : kWhite,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 10,
                              ),
                              child: Text(
                                "Income",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: _selectedMethod == 1 ? kWhite : kBlack,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Container(
                    margin: EdgeInsets.only(top: height * 0.15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "How Much?",
                          style: TextStyle(
                            color: kLightGrey.withOpacity(0.8),
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const TextField(
                          style: TextStyle(
                            fontSize: 60,
                            color: kWhite,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                              hintText: "0",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: kWhite,
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                              )),
                        )
                      ],
                    ),
                  ),
                ),

                // User Data Form

                Container(
                  height: height * 0.7,
                  margin: EdgeInsets.only(top: height * 0.31),
                  decoration: const BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      child: Column(
                        children: [
                          // Drop Down fot Category
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: kDefaultPadding,
                                horizontal: 20,
                              ),
                            ),
                            items: _selectedMethod == 0
                                ? ExpenseCategory.values.map((category) {
                                    return DropdownMenuItem(
                                      value: category,
                                      child: Text(category.name),
                                    );
                                  }).toList()
                                : IncomeCategory.values.map((category) {
                                    return DropdownMenuItem(
                                      value: category,
                                      child: Text(category.name),
                                    );
                                  }).toList(),
                            value: _selectedMethod == 0
                                ? _expensecategory
                                : _incomeCategory,
                            onChanged: (value) {
                              setState(() {
                                _selectedMethod == 0
                                    ? _expensecategory =
                                        value as ExpenseCategory
                                    : _incomeCategory = value as IncomeCategory;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _titleController,
                            decoration: InputDecoration(
                              hintText: "Title",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: kDefaultPadding,
                                horizontal: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              hintText: "Description",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: kDefaultPadding,
                                horizontal: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _amountController,
                            decoration: InputDecoration(
                              hintText: "Amount",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: kDefaultPadding,
                                horizontal: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          // Date Picker
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime(2026),
                                  ).then((value) {
                                    if (value != null) {
                                      setState(() {
                                        _selectedDate = value;
                                      });
                                      print(_selectedDate);
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: kMainColor,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month_outlined,
                                          color: kWhite,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Select Date",
                                          style: TextStyle(
                                            color: kWhite,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                DateFormat.yMMMd().format(_selectedDate),
                                style: TextStyle(
                                  color: kBlack.withOpacity(0.6),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Time Picker
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    if (value != null) {
                                      setState(() {
                                        _selectedTime = DateTime(
                                          _selectedDate.year,
                                          _selectedDate.month,
                                          _selectedDate.day,
                                          value.hour,
                                          value.minute,
                                        );
                                      });
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: kYellow,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.timer,
                                          color: kWhite,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Select Time",
                                          style: TextStyle(
                                            color: kWhite,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                DateFormat.jm().format(_selectedTime),
                                style: TextStyle(
                                  color: kBlack.withOpacity(0.6),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Divider(
                            color: kLightGrey,
                            thickness: 5,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Submit Button
                          GestureDetector(
                            onTap: () async {
                              if (_selectedMethod == 0) {
                                // Save Data in Shared Preference
                                List<Expense> loadedExpenses =
                                    await ExpenseService().loadExpenses();

                                // Create the Expense to Store
                                Expense expense = Expense(
                                  id: loadedExpenses.length + 1,
                                  title: _titleController.text,
                                  amount: _amountController.text.isEmpty
                                      ? 0
                                      : double.parse(_amountController.text),
                                  category: _expensecategory,
                                  date: _selectedDate,
                                  time: _selectedTime,
                                  description: _descriptionController.text,
                                );

                                widget.addExpense(expense);

                                // Clear the Fields
                                _titleController.clear();
                                _amountController.clear();
                                _descriptionController.clear();
                              } else {
                                // Save Data in Shared Preference
                                List<Income> loadedIncomes =
                                    await IncomeService().loadIncomes();

                                // Create the Expense to Store
                                Income income = Income(
                                  id: loadedIncomes.length + 1,
                                  title: _titleController.text,
                                  amount: _amountController.text.isEmpty
                                      ? 0
                                      : double.parse(_amountController.text),
                                  category: _incomeCategory,
                                  date: _selectedDate,
                                  time: _selectedTime,
                                  description: _descriptionController.text,
                                );

                                widget.addIncome(income);

                                // clear the Fields
                                _titleController.clear();
                                _amountController.clear();
                                _descriptionController.clear();
                              }
                            },
                            child: CustomButton(
                              buttonName: "Add",
                              buttonColor: _selectedMethod == 0 ? kRed : kGreen,
                            ),
                          )
                        ],
                      ),
                    ),
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
