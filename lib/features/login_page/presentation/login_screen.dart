import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konar_mobile/core/presentation/primary_button.dart';
import 'package:konar_mobile/core/presentation/text_field.dart';
import 'package:konar_mobile/core/utils/app_router.dart';
import 'package:konar_mobile/features/main_page/presentation/main_page.dart';

import 'login_controller.dart';
import 'widgets/big_welcome_text.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final TextEditingController _controllerLogin = TextEditingController(text: 'atuny0');

  final TextEditingController _controllerPassword = TextEditingController(text: '9uQFF1Lh');

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      loginScreenControllerProvider,
          (_, state) {
        if (!state.isLoading && state.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error.toString())),
          );
        }
      },
    );
    final state = ref.watch(loginScreenControllerProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 24,
              ),
              BigWelcomeText(text: 'Добро пожаловать!'),
              const SizedBox(
                height: 32,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFieldItem(
                      controller: _controllerLogin,
                      formName: 'Логин',
                      canHidePassword: false,
                    ),
                    TextFieldItem(
                      controller: _controllerPassword,
                      formName: 'Пароль',
                      canHidePassword: true,
                    ),
                    PrimaryButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            ref
                                .read(loginScreenControllerProvider.notifier)
                                .signInAnonymously(_controllerLogin.text,
                                _controllerPassword.text);
                          }
                        },
                        buttonName: 'Войти'),
                    TextButton(
                      onPressed: state.isLoading
                          ? null
                          : () {
                        ref
                            .read(loginScreenControllerProvider.notifier)
                            .signInAnonymously(_controllerLogin.text,
                            _controllerPassword.text);
                      },
                      child: Text('Войти как гость'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
