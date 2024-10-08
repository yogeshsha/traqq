import 'package:either_dart/either.dart';
import '../product_model/api_model.dart';
import '../product_model/cart_list_model.dart';

abstract class ProductRepository {
  Future<Either<List<Products>, ApiModel>> getProductList() ;
}