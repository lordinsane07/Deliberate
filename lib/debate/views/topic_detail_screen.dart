import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../router/route_names.dart';

class TopicDetailScreen extends StatelessWidget {
  final String topicId; // Pass ID to fetch details

  const TopicDetailScreen({super.key, required this.topicId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Topic Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Topic Title',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Topic description goes here...'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.go(Routes.stanceSelection, extra: topicId);
              },
              child: const Text('Enter Debate'),
            ),
          ],
        ),
      ),
    );
  }
}
