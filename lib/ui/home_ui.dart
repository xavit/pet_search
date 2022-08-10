import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeUi extends StatefulWidget {
  const HomeUi({Key? key}) : super(key: key);

  @override
  State<HomeUi> createState() => _HomeUiState();
}

class _HomeUiState extends State<HomeUi> {
  late List<Map<String, dynamic>> _items = [];

  final _animalesBox = Hive.box('animales_box');

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _ubicacionController = TextEditingController();

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  void initState() {
    _verificaLocalData(); // Verifica si hay datos en el local storage

    super.initState();
  }

  _verificaLocalData() {
    final data = _animalesBox.keys.map((key) {
      final value = _animalesBox.get(key);
      return {
        "key": key,
        "nombre": value["nombre"],
        "ubicacion": value['ubicacion']
      };
    }).toList();

    setState(() {
      _items = data.reversed.toList();
      // we use "reversed" to sort items in order from the latest to the oldest
    });
  }

  // Crear nuevo item
  Future<void> _createItem(Map<String, dynamic> newItem) async {
    await _animalesBox.add(newItem);
    _verificaLocalData(); // update the UI
  }

  // Retorna un solo ítem de la BD Local usando su key
  // Esta app no usara esta funcion pero la pongo por referencia
  Map<String, dynamic> _readItem(int key) {
    final item = _animalesBox.get(key);
    return item;
  }

  // Actualiza un ítem de la BD Local usando su key
  Future<void> _updateItem(int itemKey, Map<String, dynamic> item) async {
    await _animalesBox.put(itemKey, item);
    _verificaLocalData(); // Actualiza la UI
  }

  // Borra un solo item
  Future<void> _deleteItem(int itemKey) async {
    await _animalesBox.delete(itemKey);
    _verificaLocalData(); // update the UI

    // Muestra un snackbar
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Un elemento ha sido borrado')));
  }

  void _showForm(BuildContext ctx, int? itemKey) async {
    // itemKey == null -> create new item
    // itemKey != null -> update an existing item

    if (itemKey != null) {
      final existingItem =
          _items.firstWhere((element) => element['key'] == itemKey);
      _nombreController.text = existingItem['nombre'];
      _ubicacionController.text = existingItem['ubicacion'];
    }

    showModalBottomSheet(
      context: ctx,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
            top: 15,
            left: 15,
            right: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _nombreController,
              keyboardType: TextInputType.text,
              decoration:
                  const InputDecoration(hintText: 'Tipo o nombre del Animal'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _ubicacionController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(hintText: 'Ubicación'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                // Guardar nuevo item
                if (itemKey == null) {
                  _createItem({
                    "nombre": _nombreController.text,
                    "ubicacion": _ubicacionController.text
                  });
                }

                // actualizar un item existente
                if (itemKey != null) {
                  _updateItem(itemKey, {
                    'nombre': _nombreController.text.trim(),
                    'ubicacion': _ubicacionController.text.trim()
                  });
                }

                // Clear the text fields
                _nombreController.text = '';
                _ubicacionController.text = '';

                Navigator.of(context).pop(); // Cerrar el bottom sheet
              },
              child: Text(itemKey == null ? 'Crear Nuevo' : 'Actualizar'),
            ),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animales encontrados'),
      ),
      body: _items.isEmpty
          ? const Center(
              child: Text(
                'No hay elementos',
                style: TextStyle(fontSize: 30),
              ),
            )
          : ListView.builder(
              // the list of items
              itemCount: _items.length,
              itemBuilder: (_, index) {
                final currentItem = _items[index];
                return Card(
                  color: Colors.orange.shade100,
                  margin: const EdgeInsets.all(10),
                  elevation: 3,
                  child: ListTile(
                      title: Text(currentItem['nombre']),
                      subtitle: Text(currentItem['ubicacion'].toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Edit button
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _showForm(context, currentItem['key'])),
                          // Delete button
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteItem(currentItem['key']),
                          ),
                        ],
                      )),
                );
              }),
      // Boton para crear nuevo item
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(context, null),
        child: const Icon(Icons.add),
      ),
    );
  }
}
