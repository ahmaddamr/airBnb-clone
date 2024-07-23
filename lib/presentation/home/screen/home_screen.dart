import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const nav = 'HomeScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('home')),
    );
  }
}