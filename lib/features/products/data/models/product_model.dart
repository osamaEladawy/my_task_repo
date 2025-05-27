import 'package:my_task_products/features/products/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    required this.tags,
    this.brand,
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    required this.reviews,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.meta,
    required this.images,
    this.thumbnail,
  }) : super(
         id: id,
         description: description,
         discountPercentage: discountPercentage,
         images: images,
         price: price,
         reviews: reviews,
         shippingInformation: shippingInformation,
         title: title,
         rating: rating,
       );

  final int? id;
  final String? title;
  final String? description;
  final String? category;
  final num? price;
  final num? discountPercentage;
  final num? rating;
  final num? stock;
  final List<String> tags;
  final String? brand;
  final String? sku;
  final num? weight;
  final Dimensions? dimensions;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;
  final List<Review> reviews;
  final String? returnPolicy;
  final num? minimumOrderQuantity;
  final Meta? meta;
  final List<String> images;
  final String? thumbnail;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      category: json["category"],
      price: json["price"],
      discountPercentage: json["discountPercentage"],
      rating: json["rating"],
      stock: json["stock"],
      tags:
          json["tags"] == null
              ? []
              : List<String>.from(json["tags"]!.map((x) => x)),
      brand: json["brand"],
      sku: json["sku"],
      weight: json["weight"],
      dimensions:
          json["dimensions"] == null
              ? null
              : Dimensions.fromJson(json["dimensions"]),
      warrantyInformation: json["warrantyInformation"],
      shippingInformation: json["shippingInformation"],
      availabilityStatus: json["availabilityStatus"],
      reviews:
          json["reviews"] == null
              ? []
              : List<Review>.from(
                json["reviews"]!.map((x) => Review.fromJson(x)),
              ),
      returnPolicy: json["returnPolicy"],
      minimumOrderQuantity: json["minimumOrderQuantity"],
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      images:
          json["images"] == null
              ? []
              : List<String>.from(json["images"]!.map((x) => x)),
      thumbnail: json["thumbnail"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "category": category,
    "price": price,
    "discountPercentage": discountPercentage,
    "rating": rating,
    "stock": stock,
    "tags": tags.map((x) => x).toList(),
    "brand": brand,
    "sku": sku,
    "weight": weight,
    "dimensions": dimensions?.toJson(),
    "warrantyInformation": warrantyInformation,
    "shippingInformation": shippingInformation,
    "availabilityStatus": availabilityStatus,
    "reviews": reviews.map((x) => x.toJson()).toList(),
    "returnPolicy": returnPolicy,
    "minimumOrderQuantity": minimumOrderQuantity,
    "meta": meta?.toJson(),
    "images": images.map((x) => x).toList(),
    "thumbnail": thumbnail,
  };

  @override
  String toString() {
    return "$id, $title, $description, $category, $price, $discountPercentage, $rating, $stock, $tags, $brand, $sku, $weight, $dimensions, $warrantyInformation, $shippingInformation, $availabilityStatus, $reviews, $returnPolicy, $minimumOrderQuantity, $meta, $images, $thumbnail, ";
  }
}

class Dimensions {
  Dimensions({required this.width, required this.height, required this.depth});

  final num? width;
  final num? height;
  final num? depth;

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return Dimensions(
      width: json["width"],
      height: json["height"],
      depth: json["depth"],
    );
  }

  Map<String, dynamic> toJson() => {
    "width": width,
    "height": height,
    "depth": depth,
  };

  @override
  String toString() {
    return "$width, $height, $depth, ";
  }
}

class Meta {
  Meta({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? barcode;
  final String? qrCode;

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      barcode: json["barcode"],
      qrCode: json["qrCode"],
    );
  }

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "barcode": barcode,
    "qrCode": qrCode,
  };

  @override
  String toString() {
    return "$createdAt, $updatedAt, $barcode, $qrCode, ";
  }
}

class Review {
  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  final int? rating;
  final String? comment;
  final DateTime? date;
  final String? reviewerName;
  final String? reviewerEmail;

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: json["rating"],
      comment: json["comment"],
      date: DateTime.tryParse(json["date"] ?? ""),
      reviewerName: json["reviewerName"],
      reviewerEmail: json["reviewerEmail"],
    );
  }

  Map<String, dynamic> toJson() => {
    "rating": rating,
    "comment": comment,
    "date": date?.toIso8601String(),
    "reviewerName": reviewerName,
    "reviewerEmail": reviewerEmail,
  };

  @override
  String toString() {
    return "$rating, $comment, $date, $reviewerName, $reviewerEmail, ";
  }
}
