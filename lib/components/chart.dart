import 'package:flutter/material.dart';
import 'package:flutter_expenses/components/chart_bar.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMonth = recentTransaction[i].date.month == weekDay.month;
        bool sameYear = recentTransaction[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransaction[i].value;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    groupTransactions;
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: groupTransactions.map((tr) {
          return ChartBar(
              label: tr['day'].toString(),
              value: tr['value'] as double,
              percentage: 0);
        }).toList(),
      ),
    );
  }
}
