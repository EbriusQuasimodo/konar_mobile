import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konar_mobile/features/login_page/data/login_repository.dart';

class AuthButtonWidget extends ConsumerWidget {
  const AuthButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)),
        height: 40,
        onPressed: () {
          ref.read(realAuthRepositoryProvider).logOut();
        },
        color: const Color(0xff0D1F61),
        child: const Text(
          'Авторизоваться',
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
