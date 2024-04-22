import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class UserModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String gender;

  @HiveField(4)
  final String qualification;

  @HiveField(5)
  final List<String> hobbies;

  @HiveField(6)
  final bool darkMode;

  UserModel({
    required this.name,
    required this.email,
    required this.gender,
    required this.qualification,
    required this.hobbies,
    required this.darkMode,
    this.id,
  });
}
