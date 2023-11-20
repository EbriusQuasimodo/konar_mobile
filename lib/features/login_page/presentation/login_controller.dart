import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konar_mobile/features/login_page/data/login_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_controller.g.dart';

@riverpod
class LoginScreenController extends _$LoginScreenController {
  @override
  FutureOr<void> build() {
    // no-op
  }

  Future<void> signInAnonymously(String login, String password) async {
    state = const AsyncLoading();
    final authRepository = ref.read(realAuthRepositoryProvider);
    state = await AsyncValue.guard(() {return authRepository.logIn(login, password);});
  }
}
