import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_task_products/features/products/data/models/product_model.dart';
import 'package:my_task_products/features/products/domain/usecases/delete_product_use_case.dart';

part 'delete_product_state.dart';

class DeleteProductCubit extends Cubit<DeleteProductState> {
  DeleteProductCubit({required this.deleteProductUseCase})
    : super(DeleteProductInitial());

  final DeleteProductUseCase deleteProductUseCase;

  Future<void> deleteProduct({required int id}) async {
    final response = await deleteProductUseCase.call(id: id);
    response.fold(
      (error) => emit(DeleteProductError(message: error.message!)),
      (model) => emit(DeleteProductSuccess(productModel: model)),
    );
  }
}
