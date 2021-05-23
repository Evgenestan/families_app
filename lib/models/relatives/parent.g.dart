// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParentAdapter extends TypeAdapter<Parent> {
  @override
  final int typeId = 0;

  @override
  Parent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Parent(
      id: fields[0] as int,
      surname: fields[1] as String,
      name: fields[2] as String,
      patronymic: fields[3] as String,
      dob: fields[4] as String,
      position: fields[5] as String,
      children: (fields[6] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, Parent obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.surname)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.patronymic)
      ..writeByte(4)
      ..write(obj.dob)
      ..writeByte(5)
      ..write(obj.position)
      ..writeByte(6)
      ..write(obj.children);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
