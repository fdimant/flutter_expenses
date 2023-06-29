import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expenses/components/transaction_form.dart';
import 'components/chart.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
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
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
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
    final mediaQuery = MediaQuery.of(context);
    bool isLanscape = mediaQuery.orientation == Orientation.landscape;

    final AppBarModel = AppBar(
      title: Text(
        'Despesas Pessoais',
      ),
      actions: [
        if (isLanscape)
          IconButton(
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
            icon: Icon(!_showChart ? Icons.bar_chart : Icons.list_sharp),
          ),
        IconButton(
          onPressed: () => _opentransactionFormModal(context),
          icon: Icon(Icons.add_box_outlined),
        ),
      ],
    );
    final availableHeight = mediaQuery.size.height - AppBarModel.preferredSize.height - mediaQuery.padding.top;

    return Scaffold(
      appBar: AppBarModel,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_showChart || !isLanscape)
                Container(
                  height: availableHeight * (isLanscape ? 0.65 : 0.3),
                  child: Chart(_recentTransactions),
                ),
              if (!_showChart || !isLanscape)
                Container(
                  height: availableHeight * 0.7,
                  child: TransactionList(_transactions, _removeTransaction),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _opentransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
