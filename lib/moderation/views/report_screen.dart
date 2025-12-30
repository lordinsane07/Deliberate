import 'package:flutter/material.dart';
import '../models/report_model.dart';
import '../services/moderation_service.dart';

class ReportScreen extends StatefulWidget {
  final String contentId;
  final String reportedUserId;

  const ReportScreen({
    super.key,
    required this.contentId,
    required this.reportedUserId,
  });

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  ReportReason _selectedReason = ReportReason.spam;
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report Content')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<ReportReason>(
              value: _selectedReason,
              onChanged: (ReportReason? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedReason = newValue;
                  });
                }
              },
              items: ReportReason.values.map<DropdownMenuItem<ReportReason>>((ReportReason value) {
                return DropdownMenuItem<ReportReason>(
                  value: value,
                  child: Text(value.toString().split('.').last),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Additional Details',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // TODO: Call ModerationService to submit report
              },
              child: const Text('Submit Report'),
            ),
          ],
        ),
      ),
    );
  }
}
