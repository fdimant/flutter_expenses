import 'package:flutter/material.dart';
import 'package:flutter_expenses/components/adaptative_button.dart';
import 'adaptative_datePicker.dart';
import 'adaptative_textField.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();

  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;
    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate!);
    _titleController.text = '';
    _valueController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              adaptativeTextField(
                controller: _titleController,
                decorationString: 'Título da Despesa',
                onSubmitted: (value) => _submitForm(),
                autofocus: true,
              ),
              adaptativeTextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: _valueController,
                decorationString: 'Valor (R\$)',
                onSubmitted: (value) => _submitForm(),
              ),
              adaptativeDatePicker(
                selectedDate: _selectedDate!,
                onDateChange: (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
              ),
              Container(
                  alignment: Alignment.bottomRight,
                  margin: EdgeInsets.all(10),
                  child: AdaptativeButton(label: 'Nova Transação', onPressed: _submitForm))
            ],
          ),
        ),
      ),
    );
  }
}
