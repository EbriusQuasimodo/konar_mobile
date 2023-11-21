import 'package:flutter_riverpod/flutter_riverpod.dart';

final whatsViewOnMapStateProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});

final initialZoomOnMapStateProvider = StateProvider.autoDispose<double>((ref) {
  return 15;
});

final longitudeListOnMapStateProvider = StateProvider.autoDispose<List<double>>((ref) {
  return [];
});

final latitudeListOnMapStateProvider = StateProvider.autoDispose<List<double>>((ref) {
  return [];
});

