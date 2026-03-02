import 'package:e_commerce_app/domain/entities/response/category/category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_dto.g.dart';

@JsonSerializable()
class CategoryDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "slug")
  final String? slug;
  @JsonKey(name: "image")
  final String? image;

  CategoryDto({
    this.id,
    this.name,
    this.slug,
    this.image,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) => _$CategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDtoToJson(this);

  Category toEntity() {
    return Category(
      id: id,
      name: name,
      slug: slug,
      image: image,
    );
  }
}

@JsonSerializable()
class CategoryResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "data")
  final List<CategoryDto>? data;

  CategoryResponseDto({
    this.message,
    this.data,
  });

  factory CategoryResponseDto.fromJson(Map<String, dynamic> json) => _$CategoryResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseDtoToJson(this);
}
