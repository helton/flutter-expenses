import 'package:flutter/material.dart';
import 'package:flutter_expenses/widgets/new_transaction.dart';

import 'models/transaction.dart';
import 'widgets/chart.dart';
import 'widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      title: 'Expenses Manager',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(
                color: Colors.white,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: "t1",
      title: "New shoes",
      amount: 69.99,
      date: DateTime.now().subtract(Duration(days: 6)),
    ),
    Transaction(
      id: "t2",
      title: "Weekly Groceries",
      amount: 16.53,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
      id: "t3",
      title: "Shopping",
      amount: 70.44,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: "t4",
      title: "New shoes",
      amount: 20.11,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: "t5",
      title: "Nintendo Switch",
      amount: 129.99,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: "t6",
      title: "Apple Pencil",
      amount: 99.99,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: "t7",
      title: "Powerbank",
      amount: 15.52,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions => _transactions
      .where(
          (tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
      .toList();

  void _addTransaction(String title, double amount, DateTime chosenDate) {
    final tx = Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      amount: amount,
      date: chosenDate,
    );
    setState(() => _transactions.add(tx));
  }

  void _removeTransaction(String id) =>
      setState(() => _transactions.removeWhere((tx) => tx.id == id));

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) => NewTransaction(_addTransaction),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses Manager'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              child: Chart(_recentTransactions),
            ),
            TransactionList(_transactions, _removeTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
