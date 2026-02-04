import 'package:flutter/material.dart';

void main() => runApp(const WorldProgressApp());

class WorldProgressApp extends StatelessWidget {
  const WorldProgressApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'World Progress',
      theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  double _clamp01(double x) => x < 0 ? 0 : (x > 1 ? 1 : x);

  double _yearProgress(DateTime now) {
    final start = DateTime(now.year, 1, 1);
    final end = DateTime(now.year + 1, 1, 1);
    final total = end.difference(start).inSeconds;
    final done = now.difference(start).inSeconds;
    return _clamp01(done / total);
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final year = now.year;
    final percent = (_yearProgress(now) * 100).toStringAsFixed(2);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0B),
      body: SafeArea(
        child: Center(
          child: Text(
            '$percent% of $year has passed',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}

