import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'empty_state.dart';
import 'food_card.dart';

class FoodStream extends StatelessWidget {
  const FoodStream({super.key, required this.foods, required this.onEdit, required this.onDelete});

  final CollectionReference<Map<String, dynamic>> foods;
  final Future<void> Function(String id, String name) onEdit;
  final Future<void> Function(String id, String name) onDelete;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: foods.orderBy('createdAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Unable to load foods.\n${snapshot.error}', textAlign: TextAlign.center));
        }
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        final documents = snapshot.data?.docs ?? [];
        if (documents.isEmpty) return const EmptyState();
        return ListView.separated(
          itemCount: documents.length,
          separatorBuilder: (_, _) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final document = documents[index];
            final name = (document.data()['name'] as String?) ?? 'Unnamed food';
            return FoodCard(
              name: name,
              onEdit: () => onEdit(document.id, name),
              onDelete: () => onDelete(document.id, name),
            );
          },
        );
      },
    );
  }
}
