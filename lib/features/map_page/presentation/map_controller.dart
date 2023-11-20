import 'package:flutter_riverpod/flutter_riverpod.dart';

final whatsViewOnMapStateProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});

final longitudeListOnMapStateProvider = StateProvider.autoDispose<List<double>>((ref) {
  return [];
});

final latitudeListOnMapStateProvider = StateProvider.autoDispose<List<double>>((ref) {
  return [];
});

