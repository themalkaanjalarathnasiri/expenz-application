import 'package:expenz_app/models/expense_model.dart';
import 'package:expenz_app/models/income_model.dart';
import 'package:expenz_app/utils/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  final Map<ExpenseCategory, double> expenseCategoryTotal;
  final Map<IncomeCategory, double> incomeCategoryTotal;
  final bool isExpense;

  const Chart({
    Key? key,
    required this.expenseCategoryTotal,
    required this.incomeCategoryTotal,
    required this.isExpense,
  }) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<PieChartSectionData> getSections() {
    List<PieChartSectionData> sections = [];
    if (widget.isExpense) {
      sections = [
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.food],
          value: widget.expenseCategoryTotal[ExpenseCategory.health] ?? 0,
          showTitle: false,
          radius: touchedIndex == 0 ? 70 : 60,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.shopping],
          value: widget.expenseCategoryTotal[ExpenseCategory.shopping] ?? 0,
          showTitle: false,
          radius: touchedIndex == 1 ? 70 : 60,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.transport],
          value: widget.expenseCategoryTotal[ExpenseCategory.transport] ?? 0,
          showTitle: false,
          radius: touchedIndex == 2 ? 70 : 60,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.subscription],
          value: widget.expenseCategoryTotal[ExpenseCategory.subscription] ?? 0,
          showTitle: false,
          radius: touchedIndex == 3 ? 70 : 60,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.food],
          value: widget.expenseCategoryTotal[ExpenseCategory.food] ?? 0,
          showTitle: false,
          radius: touchedIndex == 4 ? 70 : 60,
        ),
      ];
    } else {
      sections = [
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.salary],
          value: widget.incomeCategoryTotal[IncomeCategory.salary] ?? 0,
          showTitle: false,
          radius: touchedIndex == 0 ? 70 : 60,
        ),
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.freelance],
          value: widget.incomeCategoryTotal[IncomeCategory.freelance] ?? 0,
          showTitle: false,
          radius: touchedIndex == 1 ? 70 : 60,
        ),
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.passive],
          value: widget.incomeCategoryTotal[IncomeCategory.passive] ?? 0,
          showTitle: false,
          radius: touchedIndex == 2 ? 70 : 60,
        ),
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.freelance],
          value: widget.incomeCategoryTotal[IncomeCategory.sales] ?? 0,
          showTitle: false,
          radius: touchedIndex == 3 ? 70 : 60,
        ),
      ];
    }
    return sections.asMap().entries.map((entry) {
      int index = entry.key;
      PieChartSectionData section = entry.value;
      return section.copyWith(
        titlePositionPercentageOffset: 0.5,
        badgeWidget: index < sections.length
            ? _Badge(
                text: '${section.value?.toStringAsFixed(1)}%',
                color: section.color,
              )
            : null,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          height: 250,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Transform.rotate(
                angle: _animation.value * 2 * pi,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 0,
                    centerSpaceRadius: 70,
                    startDegreeOffset: -90,
                    sections: getSections(),
                    borderData: FlBorderData(show: false),
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "70%",
                    style: TextStyle(
                      color: kBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "of 100%",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.text,
    required this.color,
  });
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color, width: 2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.3),
            blurRadius: 3,
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
