import 'package:flutter/material.dart';

void main() {
  runApp(const SinNumApp());
}

class SinNumApp extends StatelessWidget {
  const SinNumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SinNum',
      theme: ThemeData.dark(),
      home: const Scaffold(
        body: Center(
          child: Text(
            'SinNum by DLS',
            style: TextStyle(fontSize: 28),
          ),
        ),
      ),
    );
  }
}
