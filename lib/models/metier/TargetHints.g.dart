// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TargetHints.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TargetHintsAdapter extends TypeAdapter<TargetHints> {
  @override
  final int typeId = 4;

  @override
  TargetHints read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TargetHints();
  }

  @override
  void write(BinaryWriter writer, TargetHints obj) {
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TargetHintsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
