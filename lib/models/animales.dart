import 'package:hive/hive.dart';

part 'animales.g.dart';

@HiveType(typeId: 0)
class AnimalLocalData extends HiveObject {
  @HiveField(0)
  late String foto;

  @HiveField(1)
  late String nombre;

  @HiveField(2)
  late String latitud;

  @HiveField(3)
  late String longitud;
}
