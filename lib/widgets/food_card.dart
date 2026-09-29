import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({super.key, required this.name, required this.onEdit, required this.onDelete});

  final String name;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          children: [
            Expanded(child: Text(name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500))),
            IconButton(tooltip: 'Edit food', onPressed: onEdit, icon: const Icon(Icons.edit_outlined, size: 20)),
            IconButton(tooltip: 'Delete food', onPressed: onDelete, color: Colors.redAccent, icon: const Icon(Icons.delete_outline, size: 20)),
          ],
        ),
      ),
    );
  }
}
