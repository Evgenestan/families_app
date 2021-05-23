import 'package:hive/hive.dart';

part 'child.g.dart';

@HiveType(typeId: 1)
class Child {
  Child({
    required this.id,
    required this.surname,
    required this.name,
    required this.patronymic,
    required this.dob,
  });

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String surname;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String patronymic;

  @HiveField(4)
  final String dob;
}
