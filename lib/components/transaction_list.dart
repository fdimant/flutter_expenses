// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_expenses/components/transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionList(this.transactions, this.onRemove, {super.key});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constrains) {
            return Column(
              children: [
                Text(
                  'Nenhuma Transação !',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: constrains.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.fill,
                  ),
                )
              ],
            );
          })
        : Scrollbar(
            // thumbVisibility: true,
            thickness: 10,
            scrollbarOrientation: ScrollbarOrientation.right,
            radius: Radius.circular(10),
            child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (ctx, index) {
                  final tr = transactions[index];
                  return TransactionItem(tr: tr, onRemove: onRemove);
                }),
          );
  }
}
