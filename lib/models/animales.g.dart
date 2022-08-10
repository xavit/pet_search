// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animales.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnimalLocalDataAdapter extends TypeAdapter<AnimalLocalData> {
  @override
  final int typeId = 0;

  @override
  AnimalLocalData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnimalLocalData()
      ..foto = fields[0] as String
      ..nombre = fields[1] as String
      ..latitud = fields[2] as String
      ..longitud = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, AnimalLocalData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.foto)
      ..writeByte(1)
      ..write(obj.nombre)
      ..writeByte(2)
      ..write(obj.latitud)
      ..writeByte(3)
      ..write(obj.longitud);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimalLocalDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
