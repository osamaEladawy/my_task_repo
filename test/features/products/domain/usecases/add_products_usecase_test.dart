import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_task_products/core/apis/error/error_model.dart';
import 'package:my_task_products/features/products/data/models/product_model.dart';
import 'package:my_task_products/features/products/domain/usecases/add_products_use_case.dart';

import '../../mocks/product_repo_test.mocks.dart';

void main() {
  late AddProductsUseCase useCase;
  late MockProductsRepo mockRepo;

  setUp(() {
    mockRepo = MockProductsRepo();
    useCase = AddProductsUseCase(productsRepo: mockRepo);
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

  test('should return product when add is successful', () async {
    when(
      mockRepo.addProduct(
        title: anyNamed('title'),
        description: anyNamed('description'),
        price: anyNamed('price'),
        discountPercentage: anyNamed('discountPercentage'),
        shippingInformation: anyNamed('shippingInformation'),
      ),
    ).thenAnswer((_) async => Right(product));

    final result = await useCase(
      title: 'Test',
      description: 'Desc',
      price: 100,
      discountPercentage: 10,
      shippingInformation: 'Shipping Info',
    );

    expect(result, Right(product));
    verify(
      mockRepo.addProduct(
        title: 'Test',
        description: 'Desc',
        price: 100,
        discountPercentage: 10,
        shippingInformation: 'Shipping Info',
      ),
    );
    verifyNoMoreInteractions(mockRepo);
  });

  test('should return error if add fails', () async {
    final error = ErrorModel(message: 'Failed to add product');

    when(
      mockRepo.addProduct(
        title: anyNamed('title'),
        description: anyNamed('description'),
        price: anyNamed('price'),
        discountPercentage: anyNamed('discountPercentage'),
        shippingInformation: anyNamed('shippingInformation'),
      ),
    ).thenAnswer((_) async => Left(error));

    final result = await useCase(
      title: 'Test',
      description: 'Desc',
      price: 100,
      discountPercentage: 10,
      shippingInformation: 'Shipping Info',
    );

    expect(result, Left(error));
  });
}
