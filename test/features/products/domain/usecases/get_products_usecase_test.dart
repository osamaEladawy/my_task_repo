import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_task_products/features/products/domain/usecases/get_products_use_case.dart';

import 'package:my_task_products/features/products/domain/entities/product_entity.dart';

import '../../mocks/product_repo_test.mocks.dart';

void main() {
  late GetProductsUseCase useCase;
  late MockProductsRepo mockRepo;

  setUp(() {
    mockRepo = MockProductsRepo();
    useCase = GetProductsUseCase(productsRepo: mockRepo);
  });

  final products = [
    ProductEntity(
      id: 1,
      title: 'Test 1',
      description: 'Desc 1',
      price: 100,
      discountPercentage: 10,
      shippingInformation: 'Shipping 1',
      reviews: [],
      images: [],
      rating: null,
    ),
    ProductEntity(
      id: 2,
      title: 'Test 2',
      description: 'Desc 2',
      price: 150,
      discountPercentage: 5,
      shippingInformation: 'Shipping 2',
      reviews: [],
      images: [],
      rating: null,
    ),
  ];

  test('should return list of products', () async {
    when(
      mockRepo.getProducts(limit: anyNamed('limit'), skip: anyNamed('skip')),
    ).thenAnswer((_) async => products);

    final result = await useCase(limit: 10, skip: 0);

    expect(result, products);
    verify(mockRepo.getProducts(limit: 10, skip: 0));
    verifyNoMoreInteractions(mockRepo);
  });
}
