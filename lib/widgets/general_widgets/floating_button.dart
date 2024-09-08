import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: () => {Navigator.pushNamed(context, '/best-offers')},
      backgroundColor: Theme.of(context).primaryColor,
      child: const Icon(
        Icons.shopping_basket_sharp,
        color: Colors.white,
      ),
    );
  }
}
