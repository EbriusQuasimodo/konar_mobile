// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_parameters_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginParametersModel _$LoginParametersModelFromJson(
        Map<String, dynamic> json) =>
    LoginParametersModel(
      login: json['login'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$LoginParametersModelToJson(
    LoginParametersModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('login', instance.login);
  writeNotNull('password', instance.password);
  return val;
}
