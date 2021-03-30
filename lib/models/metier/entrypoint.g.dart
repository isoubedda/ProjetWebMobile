// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entrypoint.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EntryPointAdapter extends TypeAdapter<EntryPoint> {
  @override
  final int typeId = 4;

  @override
  EntryPoint read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EntryPoint(
      resources: (fields[0] as List)?.cast<Resources>(),
    );
  }

  @override
  void write(BinaryWriter writer, EntryPoint obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.resources);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EntryPointAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
