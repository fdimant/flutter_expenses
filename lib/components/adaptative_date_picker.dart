import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChange;

  const AdaptativeDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateChange,
  });

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      onDateChange(pickedDate);
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              maximumDate: DateTime.now().add(const Duration(hours: 1)),
              minimumDate: DateTime(2019),
              initialDateTime: DateTime.now(),
              onDateTimeChanged: onDateChange,
            ),
          )
        : SizedBox(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    DateFormat('d/MM/yyy').format(selectedDate),
                  ),
                ),
                OutlinedButton(
                  onPressed: () => _showDatePicker(context),
                  style: const ButtonStyle(
                    textStyle: MaterialStatePropertyAll(TextStyle(
                      fontSize: 18,
                    )),
                  ),
                  child: const Text(
                    'Selecionar Data',
                  ),
                ),
              ],
            ),
          );
  }
}
