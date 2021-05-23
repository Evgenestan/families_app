// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChildAdapter extends TypeAdapter<Child> {
  @override
  final int typeId = 1;

  @override
  Child read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Child(
      id: fields[0] as int,
      surname: fields[1] as String,
      name: fields[2] as String,
      patronymic: fields[3] as String,
      dob: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Child obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.surname)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.patronymic)
      ..writeByte(4)
      ..write(obj.dob);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChildAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
