import 'package:flutter/material.dart';

import 'expenses.dart';

class AddExpense extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddExpenseState();
  }
}

class _AddExpenseState extends State<AddExpense> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  // For Icon Button - Text
  String showText = "No date selected";

  // For DropDown menu
  String selectedItem = "Select Item";
  List<String> itemsOfChoice = ["Select Item", "Food", "Travel", "Enjoyment", "Business"];
  DateTime? _selectedDate;

  // For icon button - OnChanged
  void _presentDatePicker() async {
    DateTime now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 10, now.month, now.day),
      lastDate: now,
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }

    if (_selectedDate != null) {
      setState(() {
        showText = 'Date:${_selectedDate!.toLocal()}'.split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Expense"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelText: "Name",
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                SizedBox(
                  height: 50,
                  width: 160,
                  child: TextFormField(
                    controller: amountController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelText: "Amount",
                      prefixIcon: Icon(Icons.currency_rupee),
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                DropdownButton<String>(
                  value: selectedItem,
                  items: itemsOfChoice.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedItem = newValue!;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 200,
                  height: 90,
                  child: IconButton(
                    onPressed: _presentDatePicker,
                    icon: Row(
                      children: [
                        const Icon(Icons.calendar_view_month),
                        Text(showText),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 45),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Create an Expense object and send it back to Home screen
                          Expense newExpense = Expense(
                            name: nameController.text,
                            item: selectedItem,
                            amount: amountController.text,
                            date: showText,
                          );
                          Navigator.pop(context, newExpense);
                        },
                        child: const Text("Save Expense"),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 45),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
