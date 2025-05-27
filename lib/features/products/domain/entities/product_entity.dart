import 'package:my_task_products/features/products/data/models/product_model.dart';

class ProductEntity {
  final int? id;
  final String? title;
  final String? description;
  final num? price;
  final num? discountPercentage;
  final String? shippingInformation;
  final List<Review> reviews;
  final List<String> images;
  final num? rating;

  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.shippingInformation,
    required this.reviews,
    required this.images,
    required this.rating,
  });
}
