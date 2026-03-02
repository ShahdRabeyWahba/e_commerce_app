import 'package:e_commerce_app/api/data/model/response/category/category_dto.dart';
import 'package:e_commerce_app/domain/entities/response/product/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_dto.g.dart';

@JsonSerializable()
class ProductDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "slug")
  final String? slug;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "imageCover")
  final String? imageCover;
  @JsonKey(name: "images")
  final List<String>? images;
  @JsonKey(name: "category")
  final CategoryDto? category;
  @JsonKey(name: "ratingsAverage")
  final double? ratingsAverage;
  @JsonKey(name: "ratingsQuantity")
  final int? ratingsQuantity;

  ProductDto({
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

  factory ProductDto.fromJson(Map<String, dynamic> json) => _$ProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);

  Product toEntity() {
    return Product(
      id: id,
      title: title,
      slug: slug,
      description: description,
      quantity: quantity,
      price: price,
      imageCover: imageCover,
      images: images,
      category: category?.toEntity(),
      ratingsAverage: ratingsAverage,
      ratingsQuantity: ratingsQuantity,
    );
  }
}

@JsonSerializable()
class ProductResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "data")
  final List<ProductDto>? data;

  ProductResponseDto({
    this.message,
    this.data,
  });

  factory ProductResponseDto.fromJson(Map<String, dynamic> json) => _$ProductResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseDtoToJson(this);
}
