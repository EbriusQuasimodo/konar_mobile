import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:konar_mobile/internal/app.dart';
import 'package:path_provider/path_provider.dart';

import 'core/utils/user/user_isar_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  await Isar.open(
    [
      UserSchema,
    ],
    inspector: true,
    directory: dir.path,
  );
  runApp(const ProviderScope(child: KonarMobile()));
}
