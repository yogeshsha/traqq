import 'package:flutter/material.dart';
import 'package:tap_effect/tap_effect.dart';

class InkWellCustom extends StatelessWidget {
  final Widget child;
  final Function onTap;
  final Function? onLongPress;

  const InkWellCustom(
      {super.key, required this.onTap, required this.child, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AnimatedTap(
        duration: const Duration(milliseconds: 200),
        minScale: 0.1,
        onTap: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            onTap();
          });
        },
        child: child,
      ),
    );
  }
}
