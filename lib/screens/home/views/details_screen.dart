import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home/components/macro.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizza_repository/pizza_repository.dart';

class DetailsScreen extends StatelessWidget {
  final String imageAddress;
  final String title;
  final double price;
  final double discountPrice;
  final Macros macros;

  const DetailsScreen(
      {super.key,
      required this.imageAddress,
      required this.title,
      required this.price,
      required this.discountPrice,
      required this.macros});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.surface),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            MyDetailsImage(
              imageAddress: imageAddress,
            ),
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
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    MyTitleAndPriceRow(
                      title: title,
                      price: price,
                      discountPrice: discountPrice,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyMacrosRow(macros: macros),
                    const SizedBox(
                      height: 60,
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
  static const double IMAGE_SIZE_FACTOR = 0.9;
  static const double IMAGE_SHADOW_BLUR = 10.0;
  final String imageAddress;

  const MyDetailsImage({super.key, required this.imageAddress});

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
          heightFactor: IMAGE_SIZE_FACTOR,
          widthFactor: IMAGE_SIZE_FACTOR,
          child: Container(
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                    color: Theme.of(context).colorScheme.shadow,
                    offset: const Offset(5, 5),
                    blurRadius: IMAGE_SHADOW_BLUR)
              ]),
              child: Image.network(imageAddress))),
    );
  }
}

class MyTitleAndPriceRow extends StatelessWidget {
  final String title;
  final double price;
  final double discountPrice;

  const MyTitleAndPriceRow(
      {super.key,
      required this.title,
      required this.price,
      required this.discountPrice});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerRight,
            child: (discountPrice > 0)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "RM ${discountPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      Text(
                        "RM ${price.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade400,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  )
                : Text(
                    "RM ${price.toStringAsFixed(2)}",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
          ),
        ),
      ],
    );
  }
}

class MyMacrosRow extends StatelessWidget {
  static const double WIDGET_WIDTH = 8.0;

  final Macros macros;

  const MyMacrosRow({super.key, required this.macros});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MyMacro(
          amount: macros.calories.toDouble(),
          icon: FontAwesomeIcons.fire,
          name: " Calorie",
        ),
        const SizedBox(
          width: WIDGET_WIDTH,
        ),
        MyMacro(
          amount: macros.protein.toDouble(),
          unit: "g",
          name: "Protein",
          icon: FontAwesomeIcons.dumbbell,
        ),
        const SizedBox(
          width: WIDGET_WIDTH,
        ),
        MyMacro(
          amount: macros.fat.toDouble(),
          icon: Icons.oil_barrel,
          name: "Fat",
        ),
        const SizedBox(
          width: WIDGET_WIDTH,
        ),
        MyMacro(
          amount: macros.carbs.toDouble(),
          icon: FontAwesomeIcons.bowlRice,
          name: "Carbs",
        ),
      ],
    );
  }
}

class MyOrderButton extends StatelessWidget {
  static const double BORDER_RADIUS = 20;

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
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(BORDER_RADIUS))),
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
