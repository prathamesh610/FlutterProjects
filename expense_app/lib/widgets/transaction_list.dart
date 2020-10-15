import 'package:flutter/material.dart';

import './transaction_item.dart';
import '../models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: [
                  Text('No transactions added yet',
                      style: Theme.of(context).textTheme.headline6),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: constraints.maxHeight * .6,
                      child: Image.asset('assets/images/waiting.png')),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return TransactionItem(
                    transaction: transactions[index], deleteTx: deleteTx);
              },
              itemCount: transactions.length,
            ),
    );
  }
}
