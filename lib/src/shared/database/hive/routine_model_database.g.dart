// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_model_database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoutineModelDatabaseAdapter extends TypeAdapter<RoutineModelDatabase> {
  @override
  final int typeId = 2;

  @override
  RoutineModelDatabase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RoutineModelDatabase(
      fields[0] as String,
      fields[1] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, RoutineModelDatabase obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.routine);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoutineModelDatabaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
