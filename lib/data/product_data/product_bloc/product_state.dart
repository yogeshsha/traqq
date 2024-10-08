part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}
class ProductLoading extends ProductState {}



class ProductListLoaded extends ProductState {
  final List<Products> list;

  const ProductListLoaded({required this.list});

  @override
  List<Object> get props => [list];
}


class ProductError extends ProductState {
  final String message;

  const ProductError({required this.message});

  @override
  List<Object> get props => [message];
}
class OtherStatusCodeProduct extends ProductState {
  final ApiModel details;

  const OtherStatusCodeProduct({required this.details});

  @override
  List<Object> get props => [details];
}