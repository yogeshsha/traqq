part of 'product_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class FetchProductListEvent extends CategoryEvent {
  const FetchProductListEvent();
}

class FetchProductInitialEvent extends CategoryEvent {
  const FetchProductInitialEvent();
}
class FetchProductLoadingEvent extends CategoryEvent {
  const FetchProductLoadingEvent();
}
