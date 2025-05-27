import 'package:dartz/dartz.dart';
import 'package:my_task_products/core/apis/api/api_services.dart';
import 'package:my_task_products/core/apis/error/error_model.dart';
import 'package:my_task_products/core/apis/error/server_exception.dart';
import 'package:my_task_products/core/apis/links/api_keys.dart';
import 'package:my_task_products/core/apis/links/end_points.dart';
import 'package:my_task_products/core/classes/my_logger.dart';
import 'package:my_task_products/features/products/data/datasources/remote/products_remote_data_source.dart';
import 'package:my_task_products/features/products/data/models/product_model.dart';

class ProductsRemoteDataSourceImp extends ProductsRemoteDataSource {
  final ApiServices apiServices;

  ProductsRemoteDataSourceImp({required this.apiServices});
  @override
  Future<List<ProductModel>> getProducts({
    required limit,
    required skip,
  }) async {
    try {
      final response = await apiServices.get(
        EndPoints.product,
        queryParameters: {ApiKeys.limit: limit, ApiKeys.skip: skip},
      );
      final List<dynamic> data = response['products'];
      final List<ProductModel> products =
          data.map((e) => ProductModel.fromJson(e)).toList();
      MyLogger.instance.printLog("products => $products");
      return products;
    } on ServerException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<ErrorModel, ProductModel>> addProducts({
    required String title,
    required String description,
    required num discountPercentage,
    required String shippingInformation,
    required num price,
  }) async {
    try {
      final response = await apiServices.post(
        EndPoints.addProduct,
        data: {
          ApiKeys.title: title,
          ApiKeys.description: description,
          ApiKeys.shippingInformation: shippingInformation,
          ApiKeys.discountPercentage: discountPercentage,
          ApiKeys.price: price,
        },
      );
      final ProductModel product = ProductModel.fromJson(response);
      MyLogger.instance.printLog("Add a New Product => $product");
      return Right(product);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<ErrorModel, ProductModel>> updateProduct({
    required String title,
    required String description,
    required double price,
    required int id,
  }) async {
    try {
      final response = await apiServices.put(
        EndPoints.updateProduct(id: id),
        data: {
          ApiKeys.title: title,
          ApiKeys.description: description,
          ApiKeys.price: price,
        },
      );
      final ProductModel product = ProductModel.fromJson(response);
      MyLogger.instance.printLog("Update Product => $product");
      return Right(product);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<ErrorModel, ProductModel>> deleteProduct({
    required int id,
  }) async {
    try {
      final response = await apiServices.delete(
        EndPoints.deleteProduct(id: id),
      );
      final ProductModel product = ProductModel.fromJson(response);
      MyLogger.instance.printLog("Delete Product => $product");
      return Right(product);
    } on ServerException catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<ProductModel>> filterProducts({
    required String sortBy,
    required String order,
  }) async {
    // TODO: implement filterProducts
    try {
      final response = await apiServices.get(
        EndPoints.product,
        queryParameters: {ApiKeys.sortBy: sortBy, ApiKeys.order: order},
      );
       MyLogger.instance.printLog("response => $response");
      final List<dynamic> data = response['products'];
       MyLogger.instance.printLog("data => $data");
      final List<ProductModel> products =
          data.map((e) => ProductModel.fromJson(e)).toList();
      MyLogger.instance.printLog("products => $products");
      return products;
    } on ServerException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
