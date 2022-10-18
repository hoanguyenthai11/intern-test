import 'package:flutter/material.dart';
import 'package:intern_assignment/models/cart_provider.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Cart>(
      create: (context) => Cart(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: HomeScreen(),
      ),
    );
  }
}
