import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';

import 'ink_well_custom.dart';

class CounterComponent extends StatelessWidget {
  final int value;
  final Function onIncrease;
  final Function onDecrease;

  const CounterComponent(
      {super.key,
      required this.value,
      required this.onIncrease,
      required this.onDecrease});

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          boxShadow: const [
            BoxShadow(color: Colors.grey,spreadRadius: 1,blurRadius: 5)
          ],
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWellCustom(
              onTap: onIncrease,
              child: Icon(Icons.add,
                  color: Theme.of(context).colorScheme.primary)),
          const SizedBox(width: 10),
          AnimatedFlipCounter(
              duration: const Duration(milliseconds: 500),
              value: value,
              textStyle: Theme.of(context).textTheme.titleSmall),
          const SizedBox(width: 10),
          InkWellCustom(
              onTap: onDecrease,
              child: Icon(Icons.remove,
                  color: Theme.of(context).colorScheme.primary))
        ],
      ),
    );
  }
}
