import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:my_task_products/core/apis/error/error_model.dart';
import 'package:my_task_products/features/products/data/models/product_model.dart';
import 'package:my_task_products/features/products/domain/usecases/delete_product_use_case.dart';

import '../../mocks/product_repo_test.mocks.dart';

void main() {
  late DeleteProductUseCase useCase;
  late MockProductsRepo mockRepo;

  setUp(() {
    mockRepo = MockProductsRepo();
    useCase = DeleteProductUseCase(productsRepo: mockRepo);
  });

  final product = ProductModel(
    id: 1,
    title: 'Test',
    description: 'Desc',
    price: 100,
    discountPercentage: 10,
    shippingInformation: 'Shipping Info',
    tags: [],
    reviews: [],
    images: [],
  );

  test('should return product when delete is successful', () async {
    when(
      mockRepo.deleteProduct(id: anyNamed('id')),
    ).thenAnswer((_) async => Right(product));

    final result = await useCase(id: 1);

    expect(result, Right(product));
    verify(mockRepo.deleteProduct(id: 1));
    verifyNoMoreInteractions(mockRepo);
  });

  test('should return error if delete fails', () async {
    final error = ErrorModel(message: 'Failed to delete product');

    when(
      mockRepo.deleteProduct(id: anyNamed('id')),
    ).thenAnswer((_) async => Left(error));

    final result = await useCase(id: 1);

    expect(result, Left(error));
  });
}
