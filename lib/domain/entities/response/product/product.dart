import 'package:e_commerce_app/domain/entities/response/category/category.dart';

class Product {
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final int? quantity;
  final int? price;
  final String? imageCover;
  final List<String>? images;
  final Category? category;
  final double? ratingsAverage;
  final int? ratingsQuantity;

  Product({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.quantity,
    this.price,
    this.imageCover,
    this.images,
    this.category,
    this.ratingsAverage,
    this.ratingsQuantity,
  });
}

class ProductResponse {
  final String? message;
  final List<Product>? data;

  ProductResponse({
    this.message,
    this.data,
  });
}
