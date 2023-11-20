import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konar_mobile/features/login_page/data/login_repository.dart';
import 'package:konar_mobile/core/presentation/auth_button_widget.dart';
import 'package:konar_mobile/features/profile_page/presentation/widgets/user_avatar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(realAuthRepositoryProvider).currentUser;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Профиль'),
          actions: [
            user?.token != null
                ? IconButton(
                    onPressed: () {
                      ref.read(realAuthRepositoryProvider).logOut();
                    },
                    icon: const Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ))
                : const SizedBox.shrink(),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UserAvatarWidget(),
            Center(
              child: Text(
                "${user?.firstName} ${user?.lastName ?? ''}",
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
            ),
            user?.token == null
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: AuthButtonWidget(),
                  )
                : user?.email != null
                    ? Center(
                        child: TextButton(
                            onPressed: () =>
                                launchUrl(Uri.parse("${user?.email}")),
                            child: Text("${user?.email}")))
                    : const SizedBox.shrink(),
          ],
        ));
  }
}
