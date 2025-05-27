import 'package:my_task_products/app_injections.dart';
import 'package:my_task_products/core/network/network_info.dart';
import 'package:my_task_products/core/network/network_info_imp.dart';
import 'package:my_task_products/features/products/data/datasources/local/products_local_data_source.dart';
import 'package:my_task_products/features/products/data/datasources/local/products_local_data_source_imp.dart';
import 'package:my_task_products/features/products/data/datasources/remote/products_remote_data_source.dart';
import 'package:my_task_products/features/products/data/datasources/remote/products_remote_data_source_imp.dart';
import 'package:my_task_products/features/products/data/repositories/products_repo_imp.dart';
import 'package:my_task_products/features/products/domain/repositories/products_repo.dart';
import 'package:my_task_products/features/products/domain/usecases/add_products_use_case.dart';
import 'package:my_task_products/features/products/domain/usecases/delete_product_use_case.dart';
import 'package:my_task_products/features/products/domain/usecases/filter_products_use_case.dart';
import 'package:my_task_products/features/products/domain/usecases/get_products_use_case.dart';
import 'package:my_task_products/features/products/domain/usecases/update_products_use_case.dart';
import 'package:my_task_products/features/products/presentation/cubit/add_product/add_product_cubit.dart';
import 'package:my_task_products/features/products/presentation/cubit/delete_product/delete_product_cubit.dart';
import 'package:my_task_products/features/products/presentation/cubit/products/filter_products/filter_products_cubit.dart';
import 'package:my_task_products/features/products/presentation/cubit/products/options/options_cubit.dart';
import 'package:my_task_products/features/products/presentation/cubit/products/product_cubit.dart';
import 'package:my_task_products/features/products/presentation/cubit/update_product/update_product_cubit.dart';

Future<void> productsInjections() async {
  //* cubit
  sl.registerFactory<ProductCubit>(
    () => ProductCubit(getProductsUseCase: sl.call()),
  );
  sl.registerFactory<AddProductCubit>(
    () => AddProductCubit(addProductsUseCase: sl.call()),
  );
  sl.registerFactory<UpdateProductCubit>(
    () => UpdateProductCubit(updateProductsUseCase: sl.call()),
  );
  sl.registerFactory<DeleteProductCubit>(
    () => DeleteProductCubit(deleteProductUseCase: sl.call()),
  );
  sl.registerFactory<FilterProductsCubit>(
    () => FilterProductsCubit(filterProductsUseCase: sl.call()),
  );
  sl.registerFactory<SharedCubit>(() => SharedCubit());

  //* uses case
  sl.registerLazySingleton(() => GetProductsUseCase(productsRepo: sl.call()));
  sl.registerLazySingleton(() => AddProductsUseCase(productsRepo: sl.call()));
  sl.registerLazySingleton(
    () => UpdateProductsUseCase(productsRepo: sl.call()),
  );
  sl.registerLazySingleton(() => DeleteProductUseCase(productsRepo: sl.call()));
  sl.registerLazySingleton(
    () => FilterProductsUseCase(productsRepo: sl.call()),
  );

  //* repo
  sl.registerLazySingleton<ProductsRepo>(
    () => ProductsRepoImp(
      productsLocalDataSource: sl.call(),
      productsRemoteDataSource: sl.call(),
      networkInfo: sl.call(),
    ),
  );

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImp(connectivity: sl.call()),
  );

  //* data source
  sl.registerLazySingleton<ProductsRemoteDataSource>(
    () => ProductsRemoteDataSourceImp(apiServices: sl.call()),
  );

  sl.registerLazySingleton<ProductsLocalDataSource>(
    () => ProductsLocalDataSourceImp(box: sl.call()),
  );
}
