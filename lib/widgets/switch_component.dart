import 'package:flutter/material.dart';

import '../constants/colors_constants.dart';
class SwitchComponent extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;

  const SwitchComponent(
      {super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 30,
      child: FittedBox(
        fit: BoxFit.fill,
        child: Switch(
          splashRadius: 0,
          value: value,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          trackOutlineWidth: WidgetStateProperty.resolveWith<double?>(
                  (Set<WidgetState> states) {
                return 0;
              }),
          onChanged: (value) => onChanged(value),
          activeColor: Theme.of(context).colorScheme.onPrimaryContainer,
          activeTrackColor: ColorsConstants.appColor,
          inactiveThumbColor: Theme.of(context).colorScheme.onPrimaryContainer,
          inactiveTrackColor: Theme.of(context).colorScheme.onTertiaryContainer
      ),
    ));
  }
}