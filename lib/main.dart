import 'package:flutter/material.dart';
import './models/transaction.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'teste',
      color: Colors.amber,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final _transaction = [
    Transaction(
      id: 't1',
      title: 'Tênis',
      value: 158.55,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Luz',
      value: 25.05,
      date: DateTime.now(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            child: Card(
              child: Text('Gráfico'),
            ),
          ),
          Container(
            width: double.infinity,
            child: Card(
              child: Text('Lista de transações'),
            ),
          )
        ],
      ),
    );
  }
}
