import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 600,
        child: transactions.isEmpty
            ? Column(
                children: [
                  Text(
                    'Nenhuma Transação !',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 300,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.fill,
                    ),
                  )
                ],
              )
            : Scrollbar(
                thumbVisibility: true,
                thickness: 10,
                scrollbarOrientation: ScrollbarOrientation.right,
                radius: Radius.circular(10),
                child: ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (ctx, index) {
                      final tr = transactions[index];
                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 5,
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(3),
                          leading: CircleAvatar(
                            radius: 30,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FittedBox(
                                child: Text('R\$ ${tr.value.toStringAsFixed(2)}'),
                              ),
                            ),
                          ),
                          title: Text(
                            tr.title,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          subtitle: Text(
                            DateFormat('d MMM y').format(tr.date),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete_outline_rounded),
                            onPressed: () => onRemove(tr.id),
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      );
                    }),
              ));
  }
}
