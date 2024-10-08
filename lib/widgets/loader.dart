import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:traqq/widgets/simple_text.dart';



class Loading extends StatelessWidget {
  final Color? color;

  const Loading({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: color ?? Colors.black.withOpacity(0.2),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color:  Theme.of(context).secondaryHeaderColor),
              const SizedBox(
                height: 5,
              ),
              const SimpleText(
                  text: "Fetching...",
                  weight: FontWeight.w600,
                  size: 18)
            ],
          ),
        ),
      ),
    );
  }
}
