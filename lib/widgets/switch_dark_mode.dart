import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traqq/widgets/switch_component.dart';

import '../utils/dark_theme_provider.dart';
import '../utils/helper.dart';

class DarkSwitch extends StatefulWidget {
  const DarkSwitch({super.key});

  @override
  State<DarkSwitch> createState() => _DarkSwitchState();
}

class _DarkSwitchState extends State<DarkSwitch> {
  bool darkMode = true;
  DarkThemeProvider themeChange = DarkThemeProvider();

  @override
  void initState() {
    setData(context);
    super.initState();
  }

  void setData(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      themeChange = Provider.of<DarkThemeProvider>(context, listen: false);
      darkMode = themeChange.darkTheme;
      AppHelper.myPrint("----------- Dark Mode -------------$darkMode");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SwitchComponent(
        onChanged: (bool value) {
          darkMode = value;
          themeChange.darkTheme = value;
          setData(context);
        },
        value: darkMode);
  }
}
