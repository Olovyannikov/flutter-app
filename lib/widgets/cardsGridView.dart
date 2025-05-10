import 'package:flutter/material.dart';

class CardsGridView extends StatelessWidget {
  const CardsGridView({super.key, required this.cards});

  final List<Image> cards;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: cards[index],
          );
        },
        itemCount: cards.length,
      ),
    );
  }
}