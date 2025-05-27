
import 'package:my_task_products/features/products/data/models/product_model.dart';

abstract class ProductsLocalDataSource {
  Future<void>cacheUsers(List<ProductModel> users);
  Future<List<ProductModel>>getUsersCaching();
}