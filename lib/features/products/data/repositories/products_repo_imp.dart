import 'package:dartz/dartz.dart';
import 'package:my_task_products/core/apis/error/error_model.dart';
import 'package:my_task_products/core/classes/my_logger.dart';
import 'package:my_task_products/core/network/network_info.dart';
import 'package:my_task_products/features/products/data/datasources/local/products_local_data_source.dart';
import 'package:my_task_products/features/products/data/datasources/remote/products_remote_data_source.dart';
import 'package:my_task_products/features/products/data/models/product_model.dart';
import 'package:my_task_products/features/products/domain/entities/product_entity.dart';
import 'package:my_task_products/features/products/domain/repositories/products_repo.dart';

class ProductsRepoImp extends ProductsRepo {
  final ProductsLocalDataSource productsLocalDataSource;
  final ProductsRemoteDataSource productsRemoteDataSource;
  final NetworkInfo networkInfo;

  ProductsRepoImp({
    required this.productsLocalDataSource,
    required this.productsRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<ProductEntity>> getProducts({
    required limit,
    required skip,
  }) async {
    if (!await networkInfo.isConnected) {
      final data = await productsLocalDataSource.getUsersCaching();
      MyLogger.instance.printLog("No Internet");
      return data;
    } else {
      try {
        final products = await productsRemoteDataSource.getProducts(
          limit: limit,
          skip: skip,
        );
        await productsLocalDataSource.cacheUsers(products);
        MyLogger.instance.printLog("connected to Internet");
        return products;
      } catch (e) {
        final data = await productsLocalDataSource.getUsersCaching();
        return data;
      }
    }
  }

  @override
  Future<Either<ErrorModel, ProductModel>> addProduct({
    required String title,
    required String description,
    required num discountPercentage,
    required String shippingInformation,
    required num price,
  }) async {
    return await productsRemoteDataSource.addProducts(
      title: title,
      description: description,
      discountPercentage: discountPercentage,
      shippingInformation: shippingInformation,
      price: price,
    );
  }

  @override
  Future<Either<ErrorModel, ProductModel>> updateProduct({
    required String title,
    required String description,
    required double price,
    required int id,
  }) async {
    return await productsRemoteDataSource.updateProduct(
      title: title,
      description: description,
      price: price,
      id: id,
    );
  }

  @override
  Future<Either<ErrorModel, ProductModel>> deleteProduct({
    required int id,
  }) async {
    return await productsRemoteDataSource.deleteProduct(id: id);
  }

  @override
  Future<List<ProductEntity>> filterProducts({
    required String sortBy,
    required String order,
  }) async {
    return await productsRemoteDataSource.filterProducts(
      sortBy: sortBy,
      order: order,
    );
  }
}
