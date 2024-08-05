import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter_application_1/screens/home/blocs/get_pizza_bloc/get_pizza_bloc.dart';
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
          imageAddress: pizzas[i].picture,
          name: pizzas[i].name,
          description: pizzas[i].description,
        );
      },
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
          color: backgroundColor ?? Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            name,
            style: TextStyle(
                color: textColor ?? Theme.of(context).colorScheme.onSecondary,
                fontWeight: FontWeight.bold,
                fontSize: 10),
          ),
        ),
      ),
    );
  }
}

class MyMenuCard extends StatelessWidget {
  final double BORDER_RADIUS = 20.0;
  final double CARD_INNER_PADDING = 15.0;

  final String imageAddress;
  final String name;
  final String description;

  const MyMenuCard(
      {super.key,
      required this.imageAddress,
      required this.name,
      required this.description});

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
              builder: (BuildContext context) => const DetailsScreen(),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: CARD_INNER_PADDING),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 16),
              child: Image.network(imageAddress),
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                MyMenuTag(
                  name: "BEEF",
                  backgroundColor: Colors.brown,
                ),
                MyMenuTag(
                  name: "SPICY",
                  backgroundColor: Colors.red,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text(
              description,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.normal,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "RM15",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "RM20",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.grey.shade500,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.add_circled_solid))
              ],
            )
          ]),
        ),
      ),
    );
  }
}
