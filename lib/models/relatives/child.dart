import 'package:hive/hive.dart';

part 'child.g.dart';

@HiveType(typeId: 1)
class Child {
  Child({
    this.id = -1,
    required this.surname,
    required this.name,
    required this.patronymic,
    required this.dob,
  });

  Child copyWith({
    String? surname,
    String? name,
    String? patronymic,
    String? dob,
    int? id,
  }) =>
      Child(
        id: id ?? this.id,
        surname: surname ?? this.surname,
        name: name ?? this.name,
        patronymic: patronymic ?? this.patronymic,
        dob: dob ?? this.dob,
      );

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
