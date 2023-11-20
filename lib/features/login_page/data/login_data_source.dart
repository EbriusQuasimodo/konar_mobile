import 'package:dio/dio.dart';
import 'package:konar_mobile/features/login_page/domain/login_parameters_model.dart';
import 'package:konar_mobile/features/login_page/domain/user_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class LoginGetDataSource {
  late final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com',
      responseType: ResponseType.json,
    ),
  )..interceptors.add(PrettyDioLogger());

  Future<UserModel> login(LoginParametersModel loginParametersModel) async {
    if (loginParametersModel.login == 'atuny0' &&
        loginParametersModel.password == '9uQFF1Lh') {
      try{
      final re = await _dio.post('/auth/login', data: {
        "username": loginParametersModel.login,
        "password": loginParametersModel.password
      });
      print(re.statusCode);
      return UserModel.fromJson(re.data);
      }on DioException catch (error) {
        print(error);
        rethrow;
      }
    } else if (loginParametersModel.login == '' &&
        loginParametersModel.password == '') {
      return UserModel(id: 123, firstName: 'Гость');
    } else {
      throw Exception();
    }
  }
}
