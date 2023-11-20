import 'dart:async';

import 'package:flutter/foundation.dart';

import 'user/user_isar_data.dart';

/// This class was imported from the migration guide for GoRouter 5.0
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<User?> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (User? _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}