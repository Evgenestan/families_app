import 'package:hive/hive.dart';

part 'parent.g.dart';

@HiveType(typeId: 0)
class Parent {
  Parent({
    required this.surname,
    required this.name,
    required this.patronymic,
    required this.dob,
    required this.position,
    this.id = -1,
    required this.children,
  });

  Parent copyWith({
    String? surname,
    String? name,
    String? patronymic,
    String? dob,
    String? position,
    int? id,
    List<int>? children,
  }) =>
      Parent(
        id: id ?? this.id,
        surname: surname ?? this.surname,
        name: name ?? this.name,
        patronymic: patronymic ?? this.patronymic,
        dob: dob ?? this.dob,
        position: position ?? this.position,
        children: children ?? this.children,
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

  @HiveField(5)
  final String position;

  @HiveField(6)
  final List<int> children;
}
