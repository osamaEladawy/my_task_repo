// products_repo_imp_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';

import 'package:my_task_products/core/apis/error/error_model.dart';
import 'package:my_task_products/core/network/network_info.dart';
import 'package:my_task_products/features/products/data/datasources/local/products_local_data_source.dart';
import 'package:my_task_products/features/products/data/datasources/remote/products_remote_data_source.dart';
import 'package:my_task_products/features/products/data/models/product_model.dart';
import 'package:my_task_products/features/products/data/repositories/products_repo_imp.dart';
import 'package:my_task_products/features/products/domain/repositories/products_repo.dart';

import '../../mocks/products_repo_imp_test.mocks.dart';

@GenerateMocks([
  ProductsLocalDataSource,
  ProductsRemoteDataSource,
  NetworkInfo,
  ProductsRepo,
])
void main() {
  late ProductsRepoImp repository;
  late MockProductsLocalDataSource mockLocalDataSource;
  late MockProductsRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockLocalDataSource = MockProductsLocalDataSource();
    mockRemoteDataSource = MockProductsRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = ProductsRepoImp(
      productsLocalDataSource: mockLocalDataSource,
      productsRemoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tProducts = [
    ProductModel(
      id: 1,
      title: 'Test Product',
      description: 'Description',
      price: 100,
      discountPercentage: 10,
      shippingInformation: 'Shipping info',
      tags: [],
      reviews: [],
      images: [],
    ),
  ];

  group('getProducts', () {
    test('should return remote data and cache it when online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        mockRemoteDataSource.getProducts(
          limit: anyNamed('limit'),
          skip: anyNamed('skip'),
        ),
      ).thenAnswer((_) async => tProducts);
      when(
        mockLocalDataSource.cacheUsers(any),
      ).thenAnswer((_) async => Future.value());

      // act
      final result = await repository.getProducts(limit: 10, skip: 0);

      // assert
      expect(result, tProducts);
      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteDataSource.getProducts(limit: 10, skip: 0));
      verify(mockLocalDataSource.cacheUsers(tProducts));
      verifyNoMoreInteractions(mockRemoteDataSource);
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should return cached data when offline', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(
        mockLocalDataSource.getUsersCaching(),
      ).thenAnswer((_) async => tProducts);

      // act
      final result = await repository.getProducts(limit: 10, skip: 0);

      // assert
      expect(result, tProducts);
      verify(mockNetworkInfo.isConnected);
      verify(mockLocalDataSource.getUsersCaching());
      verifyNoMoreInteractions(mockRemoteDataSource);
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should return cached data when remote throws exception', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        mockRemoteDataSource.getProducts(
          limit: anyNamed('limit'),
          skip: anyNamed('skip'),
        ),
      ).thenThrow(Exception('Remote error'));
      when(
        mockLocalDataSource.getUsersCaching(),
      ).thenAnswer((_) async => tProducts);

      // act
      final result = await repository.getProducts(limit: 10, skip: 0);

      // assert
      expect(result, tProducts);
      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteDataSource.getProducts(limit: 10, skip: 0));
      verify(mockLocalDataSource.getUsersCaching());
    });
  });

  group('addProduct', () {
    final tProductModel = ProductModel(
      id: 1,
      title: 'New Product',
      description: 'Description',
      price: 100,
      discountPercentage: 10,
      shippingInformation: 'Shipping info',
      tags: [],
      reviews: [],
      images: [],
    );

    test(
      'should forward addProduct call and return Right on success',
      () async {
        // arrange
        when(
          mockRemoteDataSource.addProducts(
            title: anyNamed('title'),
            description: anyNamed('description'),
            discountPercentage: anyNamed('discountPercentage'),
            shippingInformation: anyNamed('shippingInformation'),
            price: anyNamed('price'),
          ),
        ).thenAnswer((_) async => Right(tProductModel));

        // act
        final result = await repository.addProduct(
          title: 'New Product',
          description: 'Description',
          discountPercentage: 10,
          shippingInformation: 'Shipping info',
          price: 100,
        );

        // assert
        expect(result, Right(tProductModel));
        verify(
          mockRemoteDataSource.addProducts(
            title: 'New Product',
            description: 'Description',
            discountPercentage: 10,
            shippingInformation: 'Shipping info',
            price: 100,
          ),
        );
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test('should forward addProduct call and return Left on failure', () async {
      final tError = ErrorModel(message: 'Add failed');

      // arrange
      when(
        mockRemoteDataSource.addProducts(
          title: anyNamed('title'),
          description: anyNamed('description'),
          discountPercentage: anyNamed('discountPercentage'),
          shippingInformation: anyNamed('shippingInformation'),
          price: anyNamed('price'),
        ),
      ).thenAnswer((_) async => Left(tError));

      // act
      final result = await repository.addProduct(
        title: 'New Product',
        description: 'Description',
        discountPercentage: 10,
        shippingInformation: 'Shipping info',
        price: 100,
      );

      // assert
      expect(result, Left(tError));
    });
  });

  group('updateProduct', () {
    final tProductModel = ProductModel(
      id: 1,
      title: 'Updated Product',
      description: 'Updated description',
      price: 150,
      discountPercentage: 0,
      shippingInformation: '',
      tags: [],
      reviews: [],
      images: [],
    );

    test(
      'should forward updateProduct call and return Right on success',
      () async {
        // arrange
        when(
          mockRemoteDataSource.updateProduct(
            title: anyNamed('title'),
            description: anyNamed('description'),
            price: anyNamed('price'),
            id: anyNamed('id'),
          ),
        ).thenAnswer((_) async => Right(tProductModel));

        // act
        final result = await repository.updateProduct(
          title: 'Updated Product',
          description: 'Updated description',
          price: 150,
          id: 1,
        );

        // assert
        expect(result, Right(tProductModel));
        verify(
          mockRemoteDataSource.updateProduct(
            title: 'Updated Product',
            description: 'Updated description',
            price: 150,
            id: 1,
          ),
        );
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'should forward updateProduct call and return Left on failure',
      () async {
        final tError = ErrorModel(message: 'Update failed');

        // arrange
        when(
          mockRemoteDataSource.updateProduct(
            title: anyNamed('title'),
            description: anyNamed('description'),
            price: anyNamed('price'),
            id: anyNamed('id'),
          ),
        ).thenAnswer((_) async => Left(tError));

        // act
        final result = await repository.updateProduct(
          title: 'Updated Product',
          description: 'Updated description',
          price: 150,
          id: 1,
        );

        // assert
        expect(result, Left(tError));
      },
    );
  });

  group('deleteProduct', () {
    final tProductModel = ProductModel(
      id: 1,
      title: 'Deleted Product',
      description: 'Deleted description',
      price: 0,
      discountPercentage: 0,
      shippingInformation: '',
      tags: [],
      reviews: [],
      images: [],
    );

    test(
      'should forward deleteProduct call and return Right on success',
      () async {
        // arrange
        when(
          mockRemoteDataSource.deleteProduct(id: anyNamed('id')),
        ).thenAnswer((_) async => Right(tProductModel));

        // act
        final result = await repository.deleteProduct(id: 1);

        // assert
        expect(result, Right(tProductModel));
        verify(mockRemoteDataSource.deleteProduct(id: 1));
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'should forward deleteProduct call and return Left on failure',
      () async {
        final tError = ErrorModel(message: 'Delete failed');

        // arrange
        when(
          mockRemoteDataSource.deleteProduct(id: anyNamed('id')),
        ).thenAnswer((_) async => Left(tError));

        // act
        final result = await repository.deleteProduct(id: 1);

        // assert
        expect(result, Left(tError));
      },
    );
  });
}
