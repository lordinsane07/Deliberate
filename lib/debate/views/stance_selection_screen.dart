import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../router/route_names.dart';

class StanceSelectionScreen extends StatelessWidget {
  final String topicId;

  const StanceSelectionScreen({super.key, required this.topicId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Your Stance')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                // TODO: Save stance PRO
                context.go(Routes.argumentTree, extra: topicId);
              },
              child: const Text('PRO'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Save stance CON
                context.go(Routes.argumentTree, extra: topicId);
              },
              child: const Text('CON'),
            ),
          ],
        ),
      ),
    );
  }
}
