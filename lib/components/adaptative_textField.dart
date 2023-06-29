import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class adaptativeTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Function(String) onSubmitted;
  final String decorationString;
  final bool autofocus;

  adaptativeTextField({
    required this.controller,
    this.keyboardType = TextInputType.text,
    required this.onSubmitted,
    this.decorationString = '',
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.all(2.0),
            child: CupertinoTextField(
              keyboardType: keyboardType,
              controller: controller,
              placeholder: decorationString,
              onSubmitted: onSubmitted,
              autofocus: autofocus,
              padding: EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 12,
              ),
            ),
          )
        : TextField(
            keyboardType: keyboardType,
            controller: controller,
            decoration: InputDecoration(labelText: decorationString),
            onSubmitted: onSubmitted,
            autofocus: autofocus,
          );
  }
}
