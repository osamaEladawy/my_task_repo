import 'package:my_task_products/features/products/domain/entities/product_entity.dart';
import 'package:my_task_products/features/products/domain/repositories/products_repo.dart';

class GetProductsUseCase {
  final ProductsRepo productsRepo;

  GetProductsUseCase({required this.productsRepo});
  Future<List<ProductEntity>> call({required limit, required skip}) async =>
      await productsRepo.getProducts(limit: limit, skip: skip);
}
