import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:traqq/data/product_data/domain/usecases/product_usecase_interface.dart';
import 'package:traqq/data/product_data/product_bloc/product_bloc.dart';
import 'package:traqq/data/product_data/repo/product_impl.dart';
import 'package:traqq/route_generator.dart';
import 'package:traqq/utils/dark_theme_provider.dart';

import 'constants/colors_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themePreference = DarkThemeProvider();

  late ProductUseCase productUseCase;
  List<SingleChildWidget> providers = [];

  @override
  void initState() {
    setBlocProviders(context);
    setTheme();
    super.initState();
  }

  void setBlocProviders(BuildContext context) {
    productUseCase = ProductUseCase(productRepository: ProductRepositoryImpl());
    providers = [
      BlocProvider(
          create: (context) => ProductBloc(productUseCase: productUseCase))
    ];
  }

  Future<void> setTheme() async {
    themePreference.darkTheme =
        await themePreference.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themePreference;
      },
      child: Consumer<DarkThemeProvider>(

          builder: (BuildContext context, value, Widget? child) {
        return MultiBlocProvider(
          providers: providers,
          child: MaterialApp(
            initialRoute: "/splash",
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RouteGenerator.generateRoute,
            title: 'Traqq App',
            theme: Styles.themeData(themePreference.darkTheme, context),
          ),
        );
      }),
    );
  }
}
