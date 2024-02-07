import 'package:flutter/material.dart';

buildDropdownButton({
  required String label,
  required String? value,
  required Function onChanged,
  required List<DropdownMenuItem<String>> items,
}) {
  return SizedBox(
    height: 60,
    width: 100,
    child: DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      value: value,
      hint: Text('Select'),
      onChanged: (String? newValue) {
        if (newValue != null) {
          onChanged(newValue);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select an option';
        }
        return null;
      },
      items:
          items.map<DropdownMenuItem<String>>((DropdownMenuItem<String> item) {
        return DropdownMenuItem<String>(
          value: item.value,
          child: item.child,
          onTap: () {
            if (item.value != value) {
              onChanged(item.value);
            }
          },
        );
      }).toList(),
    ),
  );
}
