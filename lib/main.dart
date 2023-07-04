import 'package:e_commerce_provider/model/all_products.dart';
import 'package:e_commerce_provider/model/api_response.dart';
import 'package:e_commerce_provider/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AllData()),
          ChangeNotifierProvider(create: (_) => Products()),
          ChangeNotifierProvider(create: (_) => ApiResponse())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        ));
  }
}
