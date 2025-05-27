import 'package:my_task_products/features/products/domain/entities/product_entity.dart';
import 'package:my_task_products/features/products/domain/repositories/products_repo.dart';

class FilterProductsUseCase {
  final ProductsRepo productsRepo;

  FilterProductsUseCase({required this.productsRepo});

  Future<List<ProductEntity>> call({
    required String sortBy,
    required String order,
  }) async {
    return await productsRepo.filterProducts(sortBy: sortBy, order: order);
  }
}
