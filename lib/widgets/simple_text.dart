import 'package:flutter/material.dart';

class SimpleText extends StatelessWidget {
  final String text;
  final TextAlign? alignment;
  final TextStyle? style;
  final double? size;
  final FontWeight? weight;
  final Color? color;
  final int? maxLines;
  final TextOverflow? textOverflow;

  const SimpleText({
    super.key,
    this.alignment,
    required this.text,
    this.style,
    this.size,
    this.weight,
    this.color,
    this.textOverflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: alignment ?? TextAlign.left,
      overflow: textOverflow,
      maxLines: maxLines,
      text,
      style: style ??
          TextStyle(
              fontSize: size ?? 14,
              fontWeight: weight ?? FontWeight.w400,
              color: color ?? Theme.of(context).colorScheme.secondary),
    );
  }
}
