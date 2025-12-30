import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../router/route_names.dart';

class SummaryCheckScreen extends StatefulWidget {
  final String topicId;
  final String parentId;
  final String parentContent;

  const SummaryCheckScreen({
    super.key,
    required this.topicId,
    required this.parentId,
    required this.parentContent,
  });

  @override
  State<SummaryCheckScreen> createState() => _SummaryCheckScreenState();
}

class _SummaryCheckScreenState extends State<SummaryCheckScreen> {
  final _summaryController = TextEditingController();

  @override
  void dispose() {
    _summaryController.dispose();
    super.dispose();
  }

  void _onProceed() {
    if (_summaryController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please summarize the argument first.')),
      );
      return;
    }

    // Navigate to WriteArgumentScreen, passing the context that we've "checked"
    context.push(
      Routes.writeArgument,
      extra: {
        'topicId': widget.topicId,
        'parentId': widget.parentId,
        // In the future, we might pass the summary too for validation/display
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Check Understanding')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Before replying, please summarize the opponent\'s point in your own words.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'OPPONENT WROTE:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.parentContent,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors
                          .black87, // Force legible color on light background
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _summaryController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Your Summary',
                border: OutlineInputBorder(),
                hintText: 'They are arguing that...',
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _onProceed,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child: const Text('I Understand - Proceed to Reply'),
            ),
          ],
        ),
      ),
    );
  }
}
