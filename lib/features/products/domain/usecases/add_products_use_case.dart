import 'package:dartz/dartz.dart';
import 'package:my_task_products/core/apis/error/error_model.dart';
import 'package:my_task_products/features/products/data/models/product_model.dart';
import 'package:my_task_products/features/products/domain/repositories/products_repo.dart';

class AddProductsUseCase {
  final ProductsRepo productsRepo;

  AddProductsUseCase({required this.productsRepo});

  Future<Either<ErrorModel, ProductModel>> call({
    required String title,
    required String description,
    required num discountPercentage,
    required String shippingInformation,
    required num price,
  }) async {
    return await productsRepo.addProduct(
      title: title,
      description: description,
      discountPercentage: discountPercentage,
      shippingInformation: shippingInformation,
      price: price,
    );
  }
}
