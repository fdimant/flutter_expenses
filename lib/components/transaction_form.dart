import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit, {Key? key}) : super(key: key);

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;
    if (title.isEmpty || value <= 0) {
      return;
    }
    onSubmit(title, value);
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
              controller: titleController,
              decoration: InputDecoration(labelText: 'Título da Despesa'),
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: valueController,
              decoration: InputDecoration(labelText: 'Valor (R\$)'),
              onSubmitted: (value) => _submitForm(),
            ),
            Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: _submitForm,
                child: Text('Nova Transação'),
                style: ButtonStyle(
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
