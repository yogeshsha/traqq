import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:traqq/data/product_data/domain/product_model/cart_list_model.dart';
import 'package:traqq/screen/home/component/product_card_component.dart';
import 'package:traqq/widgets/not_found_common.dart';

import '../../../widgets/refresh_widget.dart';

class ListComponent extends StatelessWidget {
  final Function onRefresh;
  final List<Products> productList;
  final List<Products>? databaseProductList;
  final bool isHome;

  final Function(int, int) onIncrease;
  final Function(int, int) onDecrease;
  final Function(Products)? onAdd;

  const ListComponent(
      {super.key,
      required this.onRefresh,
      required this.productList,
      required this.isHome,
      this.databaseProductList,
      required this.onIncrease,
      required this.onDecrease,
      this.onAdd});

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: RefreshComponent(
        onRefresh: onRefresh,
        child: productList.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                primary: false,
                itemCount: productList.length,
                itemBuilder: (BuildContext context, int index) {
                  Products product = productList[index];

                  int id = isHome ? (product.id ?? 0 ) : (product.productId ?? 0 ) ;
                  bool isSelected = isHome ? false: true;
                  int quantity = isHome ?1: (product.quantity ?? 1);

                  if (isHome) {
                    (databaseProductList ?? []).map((e) {
                      if (e.productId == id) {
                        quantity = e.quantity ?? quantity;
                        isSelected = true;
                      }
                    }).toList();
                  }
                  String title = product.title ?? "";
                  String image = product.thumbnail ?? "";
                  double price = product.price ?? 0;

                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: ProductCardComponent(
                              title: title,
                              price: price,
                              quantity: quantity,
                              onIncrease: () {
                                int tempQuantity = quantity + 1;
                                onIncrease(id, tempQuantity);
                              },
                              isAdded: isSelected,
                              onAdd: () {
                                if (onAdd != null) {
                                  onAdd!(product);
                                }
                              },
                              onDecrease: () {
                                int tempQuantity = quantity - 1;
                                onDecrease(id, tempQuantity);
                              },
                              image: image),
                        ),
                      ),
                    ),
                  );
                },
              )
            : const Center(child: NotFoundCommon()),
      ),
    );
  }
}
