import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:my_task_products/core/apis/error/error_model.dart';
import 'package:my_task_products/features/products/data/models/product_model.dart';
import 'package:my_task_products/features/products/domain/usecases/update_products_use_case.dart';

import '../../mocks/product_repo_test.mocks.dart';

void main() {
  late UpdateProductsUseCase useCase;
  late MockProductsRepo mockRepo;

  setUp(() {
    mockRepo = MockProductsRepo();
    useCase = UpdateProductsUseCase(productsRepo: mockRepo);
  });

  final product = ProductModel(
    id: 1,
    title: 'Updated Test',
    description: 'Updated Desc',
    price: 200,
    discountPercentage: 15,
    shippingInformation: 'Updated Shipping',
    tags: [],
    reviews: [],
    images: [],
  );

  test('should return product when update is successful', () async {
    when(
      mockRepo.updateProduct(
        id: anyNamed('id'),
        title: anyNamed('title'),
        description: anyNamed('description'),
        price: anyNamed('price'),
      ),
    ).thenAnswer((_) async => Right(product));

    final result = await useCase(
      id: 1,
      title: 'Updated Test',
      description: 'Updated Desc',
      price: 200,
    );

    expect(result, Right(product));
    verify(
      mockRepo.updateProduct(
        id: 1,
        title: 'Updated Test',
        description: 'Updated Desc',
        price: 200,
      ),
    );
    verifyNoMoreInteractions(mockRepo);
  });

  test('should return error if update fails', () async {
    final error = ErrorModel(message: 'Failed to update product');

    when(
      mockRepo.updateProduct(
        id: anyNamed('id'),
        title: anyNamed('title'),
        description: anyNamed('description'),
        price: anyNamed('price'),
      ),
    ).thenAnswer((_) async => Left(error));

    final result = await useCase(
      id: 1,
      title: 'Updated Test',
      description: 'Updated Desc',
      price: 200,
    );

    expect(result, Left(error));
  });
}
