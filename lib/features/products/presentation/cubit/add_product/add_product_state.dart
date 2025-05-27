part of 'add_product_cubit.dart';

sealed class AddProductState extends Equatable {
  const AddProductState();

  @override
  List<Object> get props => [];
}

final class AddProductInitial extends AddProductState {}

final class AddProductLoading extends AddProductState {}

final class AddProductSuccess extends AddProductState {
  final ProductModel productModel;

  const AddProductSuccess({required this.productModel});
  @override
  List<Object> get props => [productModel];
}

final class AddProductError extends AddProductState {
  final String message;

  const AddProductError({required this.message});
  @override
  List<Object> get props => [message];
}
