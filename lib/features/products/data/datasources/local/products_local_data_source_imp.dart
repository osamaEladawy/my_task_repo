
import 'package:hive/hive.dart';
import 'package:my_task_products/core/classes/my_logger.dart';
import 'package:my_task_products/features/products/data/datasources/local/products_local_data_source.dart';
import 'package:my_task_products/features/products/data/models/product_model.dart';

class ProductsLocalDataSourceImp extends ProductsLocalDataSource {
  final Box box;

  ProductsLocalDataSourceImp({required this.box});
  @override
  Future<List<ProductModel>> getUsersCaching() async {
    // final data = box.values.toList();
    final data = box.get("cache_users");
    MyLogger.instance.printLog("Retrieved data: $data");
    if (data != null && data is List) {
      final userList = data.cast<Map<String, dynamic>>();
      final posts = userList.map((e) => ProductModel.fromJson(e)).toList();
      MyLogger.instance.printLog("Cached data raw: $posts");
      return posts;
    } else {
      throw Exception("No cached data found");
    }
  }

  @override
  Future<void> cacheUsers(List<ProductModel> users) async {
    await box.clear();
    final usersJson = users.map((e) => e.toJson()).toList();
    await box.put("cache_users", usersJson);
    MyLogger.instance.printLog("Data saved: $usersJson");
  }
}
