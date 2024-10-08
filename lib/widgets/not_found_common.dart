import 'package:flutter/material.dart';
import 'package:traqq/widgets/simple_text.dart';

import '../constants/colors_constants.dart';

class NotFoundCommon extends StatelessWidget {
  final String? fullText;
  final String? title;
  final String? subTitle;

  const NotFoundCommon({super.key, this.fullText, this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 3),
          child: Icon(
            Icons.hourglass_empty_outlined,
            size: 30,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Center(
            child: SimpleText(
                text: title ?? "No Results Found",
                size: 26,
                alignment: TextAlign.center,
                weight: FontWeight.w600,
                color: Theme.of(context).colorScheme.secondary),
          ),
        ),
        if ((subTitle ?? "").isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Center(
              child: SimpleText(
                  text: subTitle ?? "",
                  size: 12,
                  weight: FontWeight.w400,
                  color: ColorsConstants.descriptionColor),
            ),
          )
      ],
    );
  }
}
