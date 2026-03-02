import 'package:e_commerce_app/domain/entities/response/auth/user.dart';
import "package:json_annotation/json_annotation.dart";

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "role")
  final String? role;

  UserDto({
    this.name,
    this.email,
    this.role,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return _$UserDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserDtoToJson(this);
  }
}

extension UserDtoMapper on UserDto {
  User toEntity() {
    return User(
      name: name,
      email: email,
      role: role,
    );
  }
}
