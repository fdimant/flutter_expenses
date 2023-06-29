import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class adaptativeDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChange;

  adaptativeDatePicker({
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
        ? Container(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              maximumDate: DateTime.now().add(Duration(hours: 1)),
              minimumDate: DateTime(2019),
              initialDateTime: DateTime.now(),
              onDateTimeChanged: onDateChange,
            ),
          )
        : Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedDate == null ? 'Nenhuma Data Selecionada' : DateFormat('d/MM/yyy').format(selectedDate!),
                  ),
                ),
                OutlinedButton(
                  onPressed: () => _showDatePicker(context),
                  child: Text(
                    'Selecionar Data',
                  ),
                  style: ButtonStyle(
                    textStyle: MaterialStatePropertyAll(TextStyle(
                      fontSize: 18,
                    )),
                  ),
                ),
              ],
            ),
          );
  }
}
