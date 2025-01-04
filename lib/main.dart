import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:slayer_ai/screens/home_s.dart';

const apiKey = "AIzaSyC5M1BiWoD9pJEtreYaGhvan48D_W7eyLg";
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.reInitialize(apiKey: apiKey, enableDebugging: true);
  runApp(const MyApp());  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeS(),
    );
  }
}
