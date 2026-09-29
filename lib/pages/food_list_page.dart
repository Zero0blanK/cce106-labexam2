import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/add_food_form.dart';
import '../widgets/edit_food_dialog.dart';
import '../widgets/food_stream.dart';

class FoodListPage extends StatefulWidget {
  const FoodListPage({super.key});

  @override
  State<FoodListPage> createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  final _foodController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;

  CollectionReference<Map<String, dynamic>> get _foods =>
      FirebaseFirestore.instance.collection('foods');

  @override
  void dispose() {
    _foodController.dispose();
    super.dispose();
  }

  Future<void> _addFood() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    try {
      await _foods.add({
        'name': _foodController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });
      _foodController.clear();
      if (mounted) _showMessage('Food added successfully.');
    } catch (error) {
      if (mounted) _showMessage('Could not add food: ${_shortError(error)}');
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _editFood(String id, String currentName) async {
    final editedName = await showDialog<String>(
      context: context,
      builder: (_) => EditFoodDialog(initialName: currentName),
    );
    if (editedName == null || editedName.trim().isEmpty) {
      if (editedName != null && mounted) {
        _showMessage('Food name cannot be empty.');
      }
      return;
    }
    try {
      await _foods.doc(id).update({'name': editedName.trim()});
      if (mounted) _showMessage('Food updated successfully.');
    } catch (error) {
      if (mounted) _showMessage('Could not update food: ${_shortError(error)}');
    }
  }

  Future<void> _deleteFood(String id, String name) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete food?'),
        content: Text('Remove "$name" from your food list?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton.tonal(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await _foods.doc(id).delete();
      if (mounted) _showMessage('Food deleted.');
    } catch (error) {
      if (mounted) _showMessage('Could not delete food: ${_shortError(error)}');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  String _shortError(Object error) =>
      error.toString().replaceFirst('Exception: ', '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LabExam2 - NEROSA',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'About this app',
            onPressed: () => showAboutDialog(
              context: context,
              applicationName: 'My Food List',
              applicationVersion: '1.0.0',
              children: const [
                Text('A Firestore CRUD app for managing favorite foods.'),
              ],
            ),
            icon: const Icon(Icons.more_horiz),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AddFoodForm(
                    formKey: _formKey,
                    controller: _foodController,
                    isSaving: _isSaving,
                    onSubmit: _addFood,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: FoodStream(
                      foods: _foods,
                      onEdit: _editFood,
                      onDelete: _deleteFood,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
