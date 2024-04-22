import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 1)
class UserModel {
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
  final String photo;

  UserModel({
    required this.photo,
    required this.name,
    required this.email,
    required this.gender,
    required this.qualification,
    required this.hobbies,
    this.id,
  });
}
