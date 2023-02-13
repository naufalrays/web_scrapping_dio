import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_scrapping/home.dart';
import 'package:web_scrapping/view_models.dart/home_view_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
