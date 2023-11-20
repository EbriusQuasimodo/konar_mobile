import 'package:isar/isar.dart';

part 'user_isar_data.g.dart';

@collection
class User {
  final Id isarId = 0;
  int? id;
  String? username;
  String? token;
  String? firstName;
  String? lastName;
  String? email;
  String? image;
  String? gender;
}
