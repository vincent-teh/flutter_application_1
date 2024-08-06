import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter_application_1/screens/home/blocs/get_pizza_bloc/get_pizza_bloc.dart';
import 'package:flutter_application_1/screens/home/components/menu_row.dart';
import 'package:flutter_application_1/screens/home/views/details_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_repository/pizza_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Row(children: [
          Icon(Icons.food_bank),
          SizedBox(width: 5),
          Text(
            'PIZZA',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          )
        ]),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.cart)),
          IconButton(
              onPressed: () {
                context.read<SignInBloc>().add(SignOutRequired());
              },
              icon: const Icon(CupertinoIcons.arrow_right_to_line)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child:
            BlocBuilder<GetPizzaBloc, GetPizzaState>(builder: (context, state) {
          if (state is GetPizzaSuccess) {
            return MyHomePageGridView(
              itemCount: state.pizzas.length,
              pizzas: state.pizzas,
            );
          }
          if (state is GetPizzaLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const Center(
            child: Text("Error has occured"),
          );
        }),
      ),
    );
  }
}

class MyHomePageGridView extends StatelessWidget {
  final int itemCount;
  final List<Pizza> pizzas;

  const MyHomePageGridView(
      {super.key, required this.itemCount, required this.pizzas});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
          childAspectRatio: 9 / 16),
      itemCount: itemCount,
      itemBuilder: (context, i) {
        return MyMenuCard(
          pizza: pizzas[i],
        );
      },
    );
  }
}

class MyMenuCard extends StatelessWidget {
  final double BORDER_RADIUS = 20.0;
  final double CARD_INNER_PADDING = 15.0;

  final Pizza pizza;

  const MyMenuCard({super.key, required this.pizza});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(BORDER_RADIUS),
      color: Theme.of(context).colorScheme.secondaryContainer,
      elevation: 3.0,
      shadowColor: Colors.grey.shade300,
      child: InkWell(
        borderRadius: BorderRadius.circular(BORDER_RADIUS),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => DetailsScreen(
                title: pizza.name,
                imageAddress: pizza.picture,
                price: pizza.price.toDouble(),
                discountPrice: pizza.discount.toDouble(),
                macros: pizza.macros,
              ),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: CARD_INNER_PADDING),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 16),
              child: Image.network(pizza.picture),
            ),
            const SizedBox(
              height: 20,
            ),
            MyMenuTagRow(
              isVege: pizza.isVeg,
              spicyLevel: pizza.spicyLevel,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(pizza.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text(
              pizza.description,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.normal,
              ),
            ),
            MyPriceWidget(
              price: pizza.price.toDouble(),
              discountPrice: pizza.discount.toDouble(),
            ),
          ]),
        ),
      ),
    );
  }
}

class MyPriceWidget extends StatelessWidget {
  final double price;
  final double discountPrice;

  const MyPriceWidget(
      {super.key, required this.price, required this.discountPrice});

  @override
  Widget build(BuildContext context) {
    if (discountPrice == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "RM ${price.toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.add_circled_solid))
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              "RM ${price.toStringAsFixed(2)}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              "RM${discountPrice.toStringAsFixed(2)}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: Colors.grey.shade500,
                  decoration: TextDecoration.lineThrough),
            ),
          ],
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.add_circled_solid))
      ],
    );
  }
}
