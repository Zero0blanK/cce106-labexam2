import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.restaurant_menu, size: 48, color: Color(0xFF9AA8AE)),
            SizedBox(height: 10),
            Text('Your food list is empty', style: TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(height: 4),
            Text('Add your first food above.', style: TextStyle(color: Color(0xFF718087))),
          ],
        ),
      );
}
