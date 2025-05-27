part of 'update_product_cubit.dart';

sealed class UpdateProductState extends Equatable {
  const UpdateProductState();

  @override
  List<Object> get props => [];
}

final class UpdateProductInitial extends UpdateProductState {}

final class UpdateProductLoading extends UpdateProductState {}

final class UpdateProductSuccess extends UpdateProductState {
  final ProductModel productModel;

  const UpdateProductSuccess({required this.productModel});

  @override
  List<Object> get props => [productModel];
}

final class UpdateProductError extends UpdateProductState {
  final String message;

  const UpdateProductError({required this.message});
  @override
  List<Object> get props => [message];
}
