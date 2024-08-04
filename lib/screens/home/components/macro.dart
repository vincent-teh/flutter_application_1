import 'package:flutter/material.dart';

class MyMacro extends StatelessWidget {
  final double amount;
  final String? unit;
  final String name;
  final IconData icon;

  const MyMacro(
      {super.key,
      required this.amount,
      this.unit,
      required this.name,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primaryContainer,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 3,
                offset: const Offset(3, 3))
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.red,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              unit == null ? "$amount $name" : "$amount$unit $name",
              style: const TextStyle(
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ));
  }
}
