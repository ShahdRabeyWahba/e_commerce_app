import 'package:e_commerce_app/domain/entities/response/category/subcategory.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subcategory_dto.g.dart';

@JsonSerializable()
class SubcategoryDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "slug")
  final String? slug;
  @JsonKey(name: "category")
  final String? category;

  SubcategoryDto({
    this.id,
    this.name,
    this.slug,
    this.category,
  });

  factory SubcategoryDto.fromJson(Map<String, dynamic> json) => _$SubcategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SubcategoryDtoToJson(this);

  Subcategory toEntity() {
    return Subcategory(
      id: id,
      name: name,
      slug: slug,
      category: category,
    );
  }
}

@JsonSerializable()
class SubcategoryResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "data")
  final List<SubcategoryDto>? data;

  SubcategoryResponseDto({
    this.message,
    this.data,
  });

  factory SubcategoryResponseDto.fromJson(Map<String, dynamic> json) => _$SubcategoryResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SubcategoryResponseDtoToJson(this);
}
