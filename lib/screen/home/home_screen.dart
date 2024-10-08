import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traqq/constants/colors_constants.dart';
import 'package:traqq/data/product_data/domain/product_model/cart_list_model.dart';
import 'package:traqq/data/product_data/product_bloc/product_bloc.dart';
import 'package:traqq/screen/home/component/list_component.dart';
import 'package:traqq/utils/helper.dart';
import 'package:traqq/widgets/loader.dart';
import 'package:traqq/widgets/simple_text.dart';
import '../../utils/product_db.dart';
import '../../utils/toast_message.dart';
import '../../widgets/switch_dark_mode.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;

  List<Products> productList = [];
  List<Products> databaseProductList = [];

  @override
  void initState() {
    setDataBaseProduct();
    callGetListProduct(context);
    super.initState();
  }

  Future<void> setDataBaseProduct() async {
    try {
      databaseProductList = [];
      List<Map<String, dynamic>> temp =
          await ProductDatabase().getAllProducts();
      temp.map((e) {
        AppHelper.myPrint("---------- List $e---------------");

        databaseProductList.add(Products.fromJson(e));
      }).toList();
    } catch (e) {
      AppHelper.myPrint(
          "-------------- Error in Put Call List Form Database -----------");
      AppHelper.myPrint(e.toString());
      AppHelper.myPrint("-------------------------");
    }
  }

  void callInitialProduct(BuildContext context) {
    context.read<ProductBloc>().add(const FetchProductInitialEvent());
  }

  void callGetListProduct(BuildContext context) {
    context.read<ProductBloc>().add(const FetchProductListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      if (state is ProductLoading) {
        isLoading = true;
      } else if (state is ProductInitial) {
        isLoading = false;
      } else if (state is ProductListLoaded) {
        productListLoaded(context, state);
      } else if (state is ProductError) {
        productError(context, state);
      } else if (state is OtherStatusCodeProduct) {
        otherStatusCodeProduct(context, state);
      }

      return Scaffold(
          drawer: Drawer(
           child: SafeArea(
             child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  ListTile(
                      title: const SimpleText(text: "Dark Mode"),
                      textColor: Theme.of(context).primaryColor,
                      trailing: const DarkSwitch(),
                      onTap: () {})
                ],
              ),
           ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: const SimpleText(
                text: "Product List", size: 22, weight: FontWeight.w500),
            actions: [
              Stack(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/cart").then((value) {
                          if (context.mounted) {
                            setDataBaseProduct();
                            callGetListProduct(context);
                          }
                        });
                      },
                      icon:  Icon(Icons.shopping_cart_outlined,color: Theme.of(context).colorScheme.primary,)),
                  Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorsConstants.appColor),
                        child: Center(
                          child: SimpleText(
                              text: databaseProductList.length.toString(),
                              weight: FontWeight.w500,
                              size: 12,
                              color: ColorsConstants.white),
                        ),
                      ))
                ],
              ),
              const SizedBox(
                width: 15,
              )
            ],
          ),
          body: Stack(
            children: [
              ListComponent(
                  onRefresh: () => callGetListProduct(context),
                  productList: productList,
                  databaseProductList: databaseProductList,
                  isHome: true,
                  onIncrease: (int id, int quantity) async {
                    await ProductDatabase().updateQuantity(id, quantity);
                    await setDataBaseProduct();

                    setState(() {});
                  },
                  onAdd: (Products value) async {
                    await ProductDatabase().insertProduct(value.toJson());
                    await setDataBaseProduct();
                    setState(() {});
                  },
                  onDecrease: (int id, int quantity) async {
                    if (quantity < 1) {
                      await ProductDatabase().deleteProduct(id);
                    } else {
                      await ProductDatabase().updateQuantity(id, quantity);
                    }
                    await setDataBaseProduct();

                    setState(() {});
                  }),
              if (isLoading) const Loading()
            ],
          ));
    });
  }

  void productListLoaded(BuildContext context, ProductListLoaded list) {
    productList = list.list;
    callInitialProduct(context);
  }

  void productError(BuildContext context, ProductError error) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ToastMessage.showErrorMessage(context, error.message);
    });
    callInitialProduct(context);
  }

  void otherStatusCodeProduct(
      BuildContext context, OtherStatusCodeProduct message) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ToastMessage.showErrorMessage(context, message.details.message ?? "");
    });
    callInitialProduct(context);
  }
}
