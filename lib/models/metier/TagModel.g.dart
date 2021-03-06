// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TagModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TagAdapter extends TypeAdapter<Tag> {
  @override
  final int typeId = 1;

  @override
  Tag read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Tag()
      .._name = fields[0] as String
      .._id = fields[1] as String
      .._links = (fields[2] as List)?.cast<Links>();
  }

  @override
  void write(BinaryWriter writer, Tag obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj._name)
      ..writeByte(1)
      ..write(obj._id)
      ..writeByte(2)
      ..write(obj._links);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TagAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
