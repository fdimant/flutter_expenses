import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();

  final _valueController = TextEditingController();
  DateTime? _selectedDate;

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

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título da Despesa'),
              autofocus: true,
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: _valueController,
              decoration: InputDecoration(labelText: 'Valor (R\$)'),
              onSubmitted: (value) => _submitForm(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Nenhuma Data Selecionada'
                          : DateFormat('d/MM/yyy').format(_selectedDate!),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: _showDatePicker,
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
            ),
            Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: _submitForm,
                child: Text('Nova Transação'),
                style: ButtonStyle(
                  textStyle: MaterialStatePropertyAll(
                    TextStyle(fontSize: 22),
                  ),
                  backgroundColor: MaterialStatePropertyAll(Colors.purple),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
