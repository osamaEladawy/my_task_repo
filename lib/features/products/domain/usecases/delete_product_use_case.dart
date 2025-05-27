import 'package:dartz/dartz.dart';
import 'package:my_task_products/core/apis/error/error_model.dart';
import 'package:my_task_products/features/products/data/models/product_model.dart';
import 'package:my_task_products/features/products/domain/repositories/products_repo.dart';

class DeleteProductUseCase {
  final ProductsRepo productsRepo;

  DeleteProductUseCase({required this.productsRepo});

  Future<Either<ErrorModel, ProductModel>> call({required int id}) async {
    return await productsRepo.deleteProduct(id: id);
  }
}
