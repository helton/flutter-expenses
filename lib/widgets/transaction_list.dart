import 'package:flutter/material.dart';
import './../widgets/user_transaction_item.dart';
import './../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, //should be the available space
      child: ListView.builder(
        itemBuilder: (ctx, index) => UserTransactionItem(transactions[index]),
        itemCount: transactions.length,
      ),
    );
  }
}
