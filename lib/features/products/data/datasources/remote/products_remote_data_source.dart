import 'package:dartz/dartz.dart';
import 'package:my_task_products/core/apis/error/error_model.dart';
import 'package:my_task_products/features/products/data/models/product_model.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>> getProducts({required limit, required skip});
  Future<List<ProductModel>> filterProducts({
    required String sortBy,
    required String order,
  });
  Future<Either<ErrorModel, ProductModel>> addProducts({
    required String title,
    required String description,
    required num discountPercentage,
    required String shippingInformation,
    required num price,
  });
  Future<Either<ErrorModel, ProductModel>> updateProduct({
    required String title,
    required String description,
    required double price,
    required int id,
  });

  Future<Either<ErrorModel, ProductModel>> deleteProduct({required int id});
}
