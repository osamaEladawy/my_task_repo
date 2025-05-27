import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:my_task_products/features/products/data/models/product_model.dart';
import 'package:my_task_products/features/products/domain/usecases/update_products_use_case.dart';

part 'update_product_state.dart';

class UpdateProductCubit extends Cubit<UpdateProductState> {
  UpdateProductCubit({required this.updateProductsUseCase})
    : super(UpdateProductInitial());
  final UpdateProductsUseCase updateProductsUseCase;

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();

  Future<void> updateProduct({required int id}) async {
    emit(UpdateProductLoading());
    final response = await updateProductsUseCase.call(
      title: title.text.trim(),
      description: description.text.trim(),
      price: double.parse(price.text.trim()),
      id: id,
    );
    response.fold(
      (error) => emit(UpdateProductError(message: error.message!)),
      (model) {
        emit(UpdateProductSuccess(productModel: model));
        title.clear();
        description.clear();
        price.clear();
      },
    );
  }
}
