import 'package:flutter/material.dart';
import 'package:flutter_expenses/models/transaction.dart';
import 'package:intl/intl.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    var groupedTransactions = List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = recentTransactions
          .where((transaction) =>
              transaction.date.day == weekDay.day &&
              transaction.date.month == weekDay.month &&
              transaction.date.year == weekDay.year)
          .fold(0, (acc, value) => acc + value.amount);

      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSum,
      };
    });

    // add percentages
    final total = groupedTransactions.fold(
        0.0, (acc, data) => acc + (data['amount'] as double));

    groupedTransactions.forEach((data) => data['percentage'] =
        total == 0.0 ? 0.0 : (data['amount'] as double) / total);

    return groupedTransactions.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues
              .map(
                (data) => Expanded(
                  child: ChartBar(
                    data['day'],
                    data['amount'],
                    data['percentage'],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
