import 'package:json_annotation/json_annotation.dart';

part 'login_parameters_model.g.dart';
@JsonSerializable(includeIfNull: false)
class LoginParametersModel{
  final String? login;
  final String? password;

  LoginParametersModel({
    this.login,
    this.password,
  });

  factory LoginParametersModel.fromJson(Map<String, dynamic> json) =>
      _$LoginParametersModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginParametersModelToJson(this);
}