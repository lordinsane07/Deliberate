import 'package:flutter/material.dart';

class LockedStateScreen extends StatelessWidget {
  final DateTime unlockTime;

  const LockedStateScreen({super.key, required this.unlockTime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_clock, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'Reflection Period Active',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // TODO: Use CountdownTimer widget here
            const Text('Please wait before responding...'),
          ],
        ),
      ),
    );
  }
}
