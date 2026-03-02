// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subcategory_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubcategoryDto _$SubcategoryDtoFromJson(Map<String, dynamic> json) =>
    SubcategoryDto(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$SubcategoryDtoToJson(SubcategoryDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'category': instance.category,
    };

SubcategoryResponseDto _$SubcategoryResponseDtoFromJson(
  Map<String, dynamic> json,
) => SubcategoryResponseDto(
  message: json['message'] as String?,
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => SubcategoryDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SubcategoryResponseDtoToJson(
  SubcategoryResponseDto instance,
) => <String, dynamic>{'message': instance.message, 'data': instance.data};
