import 'package:either_dart/either.dart';
import '../product_model/api_model.dart';
import '../product_model/cart_list_model.dart';
import '../repo/product_repo_interface.dart';

class ProductUseCase {
  final ProductRepository productRepository;
  ProductUseCase({required this.productRepository});
  Future<Either<List<Products>, ApiModel>> getProductList() {
    return productRepository.getProductList();
  }
}
