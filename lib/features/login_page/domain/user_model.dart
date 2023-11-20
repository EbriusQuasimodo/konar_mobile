
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';
@JsonSerializable(includeIfNull: false)

class UserModel {
  final int id;
  final String? username;
  final String? token;
  final String firstName;
  final String? lastName;
  final String? email;
  final String? image;
  final String? gender;

  UserModel({
    required this.id,
    this.token,
    required this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.image,
    this.username,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
