import 'package:expenz_app/models/expense_model.dart';
import 'package:expenz_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseCard extends StatelessWidget {
  final String title;
  final DateTime date;
  final double amount;
  final ExpenseCategory category;
  final String description;
  final DateTime time;
  const ExpenseCard({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.category,
    required this.description,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: kGrey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: expenseCategoryColors[category]!.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              expenseCategoryImages[category]!,
              width: 20,
              height: 20,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kBlack.withOpacity(0.8),
                ),
              ),
              SizedBox(
                width: 150,
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: kGrey,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "-${amount.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kRed,
                ),
              ),
              Text(
                DateFormat.jm().format(date),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: kGrey,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
