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
      ownerId: fields[2] as String,
      ownerUrl: fields[3] as String,
      label: fields[4] as String,
      description: fields[5] as String,
      tags: (fields[6] as List)?.cast<Tag>(),
      coords: fields[7] as LatLng,
      image: fields[8] as ImageModel,
      creationDate: fields[9] as String,
      lastUpdate: fields[10] as String,
      links: fields[11] as Links,
    );
  }

  @override
  void write(BinaryWriter writer, PlaceModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.ownerId)
      ..writeByte(3)
      ..write(obj.ownerUrl)
      ..writeByte(4)
      ..write(obj.label)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.tags)
      ..writeByte(7)
      ..write(obj.coords)
      ..writeByte(8)
      ..write(obj.image)
      ..writeByte(9)
      ..write(obj.creationDate)
      ..writeByte(10)
      ..write(obj.lastUpdate)
      ..writeByte(11)
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
