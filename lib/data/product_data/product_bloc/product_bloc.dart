import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/product_model/api_model.dart';
import '../domain/product_model/cart_list_model.dart';
import '../domain/usecases/product_usecase_interface.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<CategoryEvent, ProductState> {
  final ProductUseCase productUseCase;

  ProductBloc({required this.productUseCase}) : super(ProductInitial()) {
    on<FetchProductListEvent>((event, emit) async {
        emit(ProductLoading());
      try {
        Either<List<Products>, ApiModel> details = await productUseCase.getProductList();
        if(details.isLeft){
          emit(ProductListLoaded(list: details.left));
        }else{
          emit(OtherStatusCodeProduct(details: details.right));
        }
      } catch (e) {
        emit(ProductError(message: e.toString()));
      }
    });
    on<FetchProductInitialEvent>((event, emit) async {
      emit(ProductInitial());
    });
    on<FetchProductLoadingEvent>((event, emit) async {
      emit(ProductLoading());
    });
  }
}
