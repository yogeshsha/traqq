import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../constants/api_constants.dart';
import '../../../utils/helper.dart';
import '../domain/product_model/api_model.dart';
import '../domain/product_model/cart_list_model.dart';
import '../domain/repo/product_repo_interface.dart';

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<Either<List<Products>, ApiModel>> getProductList() async {
    try {
      String sendUrl = ApiConstants.getProductList;
      AppHelper.myPrint(
          "------------------ Value Get Product List -------------------");
      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint("-------------------------------------");

      http.Response response = await AppHelper.callApi(url: sendUrl);
      AppHelper.myPrint(
          "------------------ Response Get Product List -------------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("-------------------------------------");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        final details = jsonData as Map<String ,dynamic>;
        CartListModel model = CartListModel.fromJson(details);
        return Left(model.products ?? []);
      } else {
        return Right(
            ApiModel(message: response.body, statusCode: response.statusCode));
      }
    } catch (e) {
      rethrow;
    }
  }
}
