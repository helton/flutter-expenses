import 'package:flutter/material.dart';
import './../widgets/new_transaction.dart';
import './../widgets/transaction_list.dart';
import './../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _transactions = [
    Transaction(
      id: "t1",
      title: "New shoes",
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "Weekly Groceries",
      amount: 16.53,
      date: DateTime.now(),
    ),
  ];

  void _addTransaction(String title, double amount) {
    final tx = Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );
    setState(() => _transactions.add(tx));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      NewTransaction(
        _addTransaction,
      ),
      TransactionList(_transactions)
    ]);
  }
}
