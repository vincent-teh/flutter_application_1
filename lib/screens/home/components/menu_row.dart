import 'package:flutter/material.dart';

class MyMenuTagRow extends StatelessWidget {
  final bool isBeef;
  final int spicyLevel;
  final bool isVege;

  const MyMenuTagRow(
      {super.key,
      this.isBeef = false,
      this.spicyLevel = 0,
      this.isVege = false});

  @override
  Widget build(BuildContext context) {
    if (isBeef && isVege) {
      return const Text("You can't have both beef and vege!");
    }
    if (!(isBeef || isVege || spicyLevel > 0)) {
      return const MyMenuTag(
        name: "",
      );
    }
    return Row(
      children: [
        if (isBeef)
          MyMenuTag(
            name: "BEEF",
            backgroundColor: Colors.brown.shade400,
          ),
        if (isVege)
          MyMenuTag(
            name: "VEGE",
            backgroundColor: Colors.green.shade400,
          ),
        if (spicyLevel > 0)
          MyMenuTag(
            name: "$spicyLevel\" SPICY",
            backgroundColor: Colors.red,
          )
      ],
    );
  }
}

class MyMenuTag extends StatelessWidget {
  final String name;
  final Color? backgroundColor;
  final Color? textColor;

  const MyMenuTag(
      {super.key, required this.name, this.backgroundColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            name,
            style: TextStyle(
                color: textColor ?? Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.bold,
                fontSize: 10),
          ),
        ),
      ),
    );
  }
}
