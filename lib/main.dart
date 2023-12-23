import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'addexpense.dart';
import 'expenses.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Expense> expenses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => AddExpense()),
              );
              if (result != null) {
                setState(() {
                  expenses.add(result as Expense);
                });
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          final expense = expenses[index];
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                setState(() {
                  expenses.removeAt(index);
                });
              },
              background: Container(
                color: CupertinoColors.systemRed,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(10),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: CupertinoDynamicColor.resolve(
                      CupertinoColors.systemRed, context),
                ),
                child: GestureDetector(
                  child: ListTile(
                    title: Row(
                      children: [
                        Text('Name: ${expense.name}',
                            style: const TextStyle(color: Colors.white)),
                        const Spacer(),
                        Text('Item: ${expense.item}',
                            style: const TextStyle(color: Colors.white)),
                        const SizedBox(height: 15)
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Text(expense.date,
                            style: const TextStyle(color: Colors.white)),
                        const Spacer(),
                        Text('Amount: ${expense.amount}',
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
