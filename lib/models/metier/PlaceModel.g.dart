// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PlaceModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaceModelAdapter extends TypeAdapter<PlaceModel> {
  @override
  final int typeId = 0;

  @override
  PlaceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlaceModel(
      id: fields[0] as String,
      description: fields[1] as String,
      label: fields[2] as String,
      tags: (fields[3] as List)?.cast<Tag>(),
      coords: fields[4] as LatLng,
      image: fields[7] as ImageModel,
      creationDate: fields[5] as String,
      lastUpdate: fields[6] as String,
      links: (fields[8] as List)?.cast<Links>(),
    );
  }

  @override
  void write(BinaryWriter writer, PlaceModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.label)
      ..writeByte(3)
      ..write(obj.tags)
      ..writeByte(4)
      ..write(obj.coords)
      ..writeByte(5)
      ..write(obj.creationDate)
      ..writeByte(6)
      ..write(obj.lastUpdate)
      ..writeByte(7)
      ..write(obj.image)
      ..writeByte(8)
      ..write(obj.links);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
