import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konar_mobile/core/presentation/auth_button_widget.dart';
import 'package:konar_mobile/features/login_page/data/login_repository.dart';
import 'package:konar_mobile/features/main_page/presentation/widgets/main_page_body_guest_widget.dart';
import 'package:konar_mobile/features/main_page/presentation/widgets/main_page_body_user_widget.dart';

class MainPage extends ConsumerWidget {
  const MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(realAuthRepositoryProvider).currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная'),
      ),
      body: user?.token == null
          ? const MainPageBodyGuestWidget()
          : const MainPageBodyUserWidget(),
    );
  }
}
