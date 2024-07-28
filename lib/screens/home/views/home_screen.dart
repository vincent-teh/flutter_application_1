import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
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
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20,
              childAspectRatio: 9 / 16),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(3, 3),
                        blurRadius: 5,
                        color: Colors.grey.shade300)
                  ]),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 16),
                      child: Image.asset('assets/1.png'),
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
                    const Text("Pepparoni",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    const Text(
                      "Lorem, ipsum dolor sit amet consectetur nobis suscipit eaque?",
                      style: TextStyle(
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
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "RM20",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(CupertinoIcons.add_circled_solid))
                      ],
                    )
                  ]),
            );
          },
        ),
      ),
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
