class CartListModel {
  List<Products>? products;

  CartListModel({this.products});

  CartListModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  int? productId;
  String? title;
  double? price;
  String? thumbnail;
  int? quantity;

  Products({this.id, this.productId,this.title, this.price, this.thumbnail});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    title = json['title'];
    quantity = json['quantity'] ?? 1;
    price = (json['price'] ?? 0).toDouble();
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['quantity'] = quantity ?? 1;
    data['thumbnail'] = thumbnail;
    return data;
  }
}
