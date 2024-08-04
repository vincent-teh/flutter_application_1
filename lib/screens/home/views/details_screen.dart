import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home/components/macro.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.surface),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const MyDetailsImage(),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(3, 3),
                      blurRadius: 3.0),
                ],
                borderRadius: BorderRadiusDirectional.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          flex: 2,
                          child: Text(
                            "Magnificant Peperoni",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "RM 15",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                                Text(
                                  "RM 20",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade400,
                                      decoration: TextDecoration.lineThrough),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        MyMacro(
                          amount: 467,
                          icon: FontAwesomeIcons.fire,
                          name: " Calorie",
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        MyMacro(
                          amount: 2.01,
                          unit: "g",
                          name: "Protein",
                          icon: FontAwesomeIcons.dumbbell,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        MyMacro(
                          amount: 10.5,
                          icon: Icons.oil_barrel,
                          name: "Fat",
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        MyMacro(
                          amount: 10,
                          icon: FontAwesomeIcons.bowlRice,
                          name: "Carbs",
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const MyOrderButton()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDetailsImage extends StatelessWidget {
  final double imageSizeFactor = 0.9;

  const MyDetailsImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        boxShadow: const [
          BoxShadow(
              color: Colors.black12, offset: Offset(3, 3), blurRadius: 3.0),
        ],
        borderRadius: BorderRadiusDirectional.circular(20.0),
      ),
      child: FractionallySizedBox(
          heightFactor: imageSizeFactor,
          widthFactor: imageSizeFactor,
          child: Image.asset("assets/1.png")),
    );
  }
}

class MyOrderButton extends StatelessWidget {
  const MyOrderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                shadowColor: Theme.of(context).colorScheme.shadow,
                elevation: 3),
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.all(6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.cart_fill),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Order Now",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ],
              ),
            )));
  }
}
