// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Resources.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResourcesAdapter extends TypeAdapter<Resources> {
  @override
  final int typeId = 5;

  @override
  Resources read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Resources(
      name: fields[0] as String,
      path: fields[1] as String,
      port: fields[2] as int,
      scheme: fields[3] as String,
      hostname: fields[4] as String,
      url: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Resources obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.path)
      ..writeByte(2)
      ..write(obj.port)
      ..writeByte(3)
      ..write(obj.scheme)
      ..writeByte(4)
      ..write(obj.hostname)
      ..writeByte(5)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResourcesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
