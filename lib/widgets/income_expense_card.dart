import 'package:expenz_app/utils/colors.dart';
import 'package:expenz_app/utils/constants.dart';
import 'package:flutter/material.dart';

class IncomeExpenseCard extends StatefulWidget {
  final Color bgColor;
  final String title;
  final double amount;
  final String image;
  const IncomeExpenseCard({
    super.key,
    required this.bgColor,
    required this.title,
    required this.amount,
    required this.image,
  });

  @override
  State<IncomeExpenseCard> createState() => _IncomeExpenseCardState();
}

class _IncomeExpenseCardState extends State<IncomeExpenseCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
        color: widget.bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.15,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Image.asset(
                  widget.image,
                  width: 70,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 18,
                    color: kWhite,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "\$${widget.amount.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 20,
                    color: kWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
