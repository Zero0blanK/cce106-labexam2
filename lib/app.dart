import 'package:flutter/material.dart';

import 'pages/food_list_page.dart';

class FoodListApp extends StatelessWidget {
  const FoodListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food List',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8FAFB),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 123, 132, 136),
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
      ),
      home: const FoodListPage(),
    );
  }
}
