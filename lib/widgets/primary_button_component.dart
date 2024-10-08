import 'package:flutter/material.dart';
import 'package:traqq/widgets/simple_text.dart';
import '../../constants/colors_constants.dart';
import 'ink_well_custom.dart';

class PrimaryButtonComponent extends StatelessWidget {
  final Function onTap;
  final String title;
  final Color? backGroundColor;
  final Color? textColor;
  final bool allowBorder;
  final Color? borderColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;

  const PrimaryButtonComponent({
    super.key,
    required this.title,
    this.allowBorder = false,
    this.backGroundColor,
    this.textColor,
    this.padding,
    this.borderColor,
    required this.onTap,
    this.margin, this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return InkWellCustom(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: padding ?? const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
        decoration: BoxDecoration(
            color: backGroundColor ?? ColorsConstants.appColor,
            borderRadius: BorderRadius.circular(10),
            border: allowBorder
                ? Border.all(color: borderColor ?? ColorsConstants.appColor)
                : null),
        margin: margin,
        alignment:alignment ,
        child: SimpleText(
            text: title,
            weight: FontWeight.w500,
            color: textColor ?? ColorsConstants.white,
            size: 16),
      ),
    );
  }
}
