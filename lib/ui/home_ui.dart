import 'package:buscador_animales/models/animales.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeUi extends StatefulWidget {
  const HomeUi({Key? key}) : super(key: key);

  @override
  State<HomeUi> createState() => _HomeUiState();
}

class _HomeUiState extends State<HomeUi> {
  late final List<AnimalLocalData> _listAnimales = [];

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  void initState() {
    _verificaLocalData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Animales encontrados'),
        ),
        body: const Center(child: Text('some')));
  }

  _verificaLocalData() async {
    // await Hive.openBox<AnimalLocalData>('animalLocalData');
    // final box = Boxes.getAnimalLocalData();

    // // print("box ${box.isEmpty}");
    // if (box.isEmpty) {
    //   debugPrint("No hay data Local");
    // } else {
    //   final animalesLocalData = box.get("animalLocalData");

    //   if (!mounted) return;
    //   setState(() {});
    // }
  }
}
