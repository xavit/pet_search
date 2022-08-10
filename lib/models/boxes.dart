import 'package:buscador_animales/models/animales.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<AnimalLocalData> getAnimalLocalData() =>
      Hive.box<AnimalLocalData>('animalLocalData');
}
