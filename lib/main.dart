import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_expenses/components/transaction_form.dart';
import 'components/chart.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
          colorSchemeSeed: Colors.purple,
//        primarySwatch: Colors.purple,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                titleMedium: TextStyle(
                  fontFamily: 'OpenSans',
                  color: const Color.fromARGB(255, 5, 63, 90),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                titleSmall: TextStyle(
                  fontFamily: 'OpenSans',
                  color: Colors.blueGrey.shade400,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'COnta Antiga',
      value: 1998.55,
      date: DateTime.now().subtract(Duration(days: 33)),
    ),
    Transaction(
      id: 't2',
      title: 'Luz',
      value: 25.50,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
      id: 't0',
      title: 'Tênis',
      value: 158.55,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _opentransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Despesas Pessoais',
        ),
        actions: [
          IconButton(
            onPressed: () => _opentransactionFormModal(context),
            icon: Icon(Icons.add_box_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            TransactionList(_transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _opentransactionFormModal(context),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
