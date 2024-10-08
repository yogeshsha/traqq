import 'package:flutter/material.dart';
import 'package:traqq/utils/product_db.dart';
import 'package:traqq/utils/toast_message.dart';

import '../../data/product_data/domain/product_model/cart_list_model.dart';
import '../../utils/helper.dart';
import '../../widgets/simple_text.dart';
import '../home/component/list_component.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Products> productList = [];

  @override
  void initState() {
    setDataBaseProduct();
    super.initState();
  }

  Future<void> setDataBaseProduct() async {
    try {
      productList = [];
      List<Map<String, dynamic>> temp =
          await ProductDatabase().getAllProducts();
      temp.map((e) {
        productList.add(Products.fromJson(e));
      }).toList();
      setState(() {});
    } catch (e) {
      AppHelper.myPrint(
          "-------------- Error in Put Call List Form Database -----------");
      AppHelper.myPrint(e.toString());
      AppHelper.myPrint("-------------------------");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const SimpleText(
              text: "Cart List", size: 22, weight: FontWeight.w500),
          actions: [
            IconButton(
                onPressed: () async {
                  double price = await ProductDatabase().getTotalPrice();
                  if (context.mounted) {
                    ToastMessage.showErrorMessage(context, "Total ${price.toStringAsFixed(22)}");
                  }
                },
                icon:  Icon(Icons.monetization_on_outlined,color: Theme.of(context).colorScheme.primary)),
            const SizedBox(
              width: 15,
            )
          ],
        ),
        body: ListComponent(
            onRefresh: () => setDataBaseProduct(),
            productList: productList,
            isHome: false,
            onIncrease: (int id, int quantity) async {
              await ProductDatabase().updateQuantity(id, quantity);
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
            }));
  }
}
