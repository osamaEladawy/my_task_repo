import 'package:dartz/dartz.dart';
import 'package:my_task_products/core/apis/error/error_model.dart';
import 'package:my_task_products/features/products/data/models/product_model.dart';
import 'package:my_task_products/features/products/domain/repositories/products_repo.dart';

class UpdateProductsUseCase {
  final ProductsRepo productsRepo;

  UpdateProductsUseCase({required this.productsRepo});

  Future<Either<ErrorModel, ProductModel>> call({
    required String title,
    required String description,
    required double price,
    required int id,
  }) async {
    return await productsRepo.updateProduct(
      title: title,
      description: description,
      price: price,
      id: id,
    );
  }
}
