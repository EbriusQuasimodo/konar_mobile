import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:konar_mobile/core/utils/user/user_isar_data.dart';
import 'package:konar_mobile/features/login_page/domain/login_parameters_model.dart';

import 'login_data_source.dart';


abstract class AuthRepositoryImpl {
  Future<void> logIn(String login, String password);
}

class RealAuthRepository implements AuthRepositoryImpl {
  RealAuthRepository(this.authDataSource, this.isar);

  final LoginGetDataSource authDataSource;
  final Isar? isar;

  Stream<User?> authStateChanges() =>
      isar?.users.watchObject(0, fireImmediately: true) ?? const Stream.empty();

  User? get currentUser => isar?.users.getSync(0);

  @override
  Future<void> logIn(String login, String password) async {
    final response = await authDataSource
        .login(LoginParametersModel(login: login, password: password));

    User userData = User()
      ..id = response.id
      ..firstName = response.firstName
      ..lastName = response.lastName
      ..token = response.token
      ..image = response.image
      ..email = response.email;
    await isar?.writeTxn(() async => await isar?.users.put(userData));
  }


  @override
  Future<void> logOut() async {
    await isar?.writeTxn(() async {
      isar?.users.delete(0);
    });
  }
}

final realAuthRepositoryProvider =
Provider.autoDispose<RealAuthRepository>((ref) {
  final authDataSource = LoginGetDataSource();
  final isar = Isar.getInstance();
  final auth = RealAuthRepository(
    authDataSource,
    isar,
  );
  return auth;
});
