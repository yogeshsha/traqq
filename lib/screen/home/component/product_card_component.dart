import 'package:flutter/material.dart';
import 'package:traqq/utils/image_builder.dart';
import 'package:traqq/widgets/increment_decrement_widget.dart';
import 'package:traqq/widgets/primary_button_component.dart';
import 'package:traqq/widgets/simple_text.dart';

class ProductCardComponent extends StatelessWidget {
  final bool isAdded;
  final String title;
  final String image;
  final double price;
  final int quantity;
  final Function onIncrease;
  final Function onAdd;
  final Function onDecrease;

  const ProductCardComponent(
      {super.key,
      required this.title,
      required this.price,
      required this.quantity,
      required this.onIncrease,
      required this.onDecrease,
      required this.image,
      required this.isAdded,
      required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Theme.of(context).colorScheme.onSurface)),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SimpleText(text: title),
              SimpleText(text: price.toStringAsFixed(2))
            ],
          )),
          Expanded(
              child: Stack(
            children: [
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: ImageBuilder.imageBuilder(image)),
              Positioned(
                  bottom: 0,
                  left: 20,
                  right: 20,
                  child: isAdded
                      ? CounterComponent(
                          value: quantity,
                          onIncrease: onIncrease,
                          onDecrease: onDecrease)
                      : PrimaryButtonComponent(
                          title: "Add",
                          onTap: onAdd,
                          alignment: Alignment.center,
                          padding:
                              const EdgeInsets.symmetric(vertical: 2),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                        ))
            ],
          )),
        ],
      ),
    );
  }
}
