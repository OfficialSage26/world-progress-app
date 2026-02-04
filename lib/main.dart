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

  String _formatDateTime(DateTime now) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    String two(int n) => n.toString().padLeft(2, '0');
    final hour12 = ((now.hour + 11) % 12) + 1;

    return '${months[now.month - 1]} ${now.day}, ${two(hour12)}:${two(now.minute)}';
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$percent% of $year has passed',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _formatDateTime(now),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 22),

              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: Container(
                  height: 18,
                  width: 280, // fixed width like the video
                  color: Colors.white.withOpacity(0.18),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: _yearProgress(now),
                      child: Container(color: const Color(0xFF33D17A)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
