// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Links.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LinksAdapter extends TypeAdapter<Links> {
  @override
  final int typeId = 3;

  @override
  Links read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Links(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Links obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj._rel)
      ..writeByte(1)
      ..write(obj._href);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LinksAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
