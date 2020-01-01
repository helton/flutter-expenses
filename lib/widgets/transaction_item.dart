import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final currencyFormatter =
      new NumberFormat.currency(locale: "pt_BR", symbol: "R\$");
  final Function removeTransaction;

  TransactionItem(this.transaction, this.removeTransaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                currencyFormatter.format(transaction.amount),
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
          ),
          color: Theme.of(context).errorColor,
          onPressed: removeTransaction,
        ),
      ),
    );
  }
}
