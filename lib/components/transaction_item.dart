import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.tr,
    required this.onRemove,
  });

  final Transaction tr;
  final void Function(String p1) onRemove;

  @override
  Widget build(BuildContext context) {
    final itemValue = NumberFormat.simpleCurrency(
      locale: 'pt_BR',
      decimalDigits: 2,
      name: 'BRL',
    );

    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
          contentPadding: const EdgeInsets.all(3),
          leading: Container(
            alignment: Alignment.centerRight,
            color: Colors.blueAccent,
            height: 40,
            width: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                child: Text(
                  itemValue.format(tr.value),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
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
          trailing: MediaQuery.of(context).size.width > 500
              ? TextButton.icon(
                  onPressed: () => onRemove(tr.id),
                  label: const Text('Remover'),
                  icon: const Icon(Icons.delete_outline_rounded),
                )
              : IconButton(
                  icon: const Icon(Icons.delete_outline_rounded),
                  onPressed: () => onRemove(tr.id),
                  color: Theme.of(context).colorScheme.error,
                )),
    );
  }
}
