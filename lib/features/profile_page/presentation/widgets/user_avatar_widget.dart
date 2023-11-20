import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konar_mobile/features/login_page/data/login_repository.dart';

class UserAvatarWidget extends ConsumerWidget {
  const UserAvatarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(realAuthRepositoryProvider).currentUser;
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border:
            Border.all(color: const Color(0xff0D1F61), width: 3)),
        child: ClipOval(
            child: SizedBox.fromSize(
              size: const Size.fromRadius(78),
              child: user?.image != null
                  ? Image.network(user?.image ?? '')
                  : const Icon(
                Icons.person,
                size: 78,
                color: Colors.black45,
              ),
            )),
      ),
    );
  }
}
