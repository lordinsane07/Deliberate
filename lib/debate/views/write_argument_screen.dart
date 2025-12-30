import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/argument_model.dart';
import '../providers/argument_tree_provider.dart';
import 'package:debate_app/core/services/api_client.dart';

class WriteArgumentScreen extends ConsumerStatefulWidget {
  final String topicId;
  final String? parentId; // If replying

  const WriteArgumentScreen({super.key, required this.topicId, this.parentId});

  @override
  ConsumerState<WriteArgumentScreen> createState() =>
      _WriteArgumentScreenState();
}

class _WriteArgumentScreenState extends ConsumerState<WriteArgumentScreen> {
  final _contentController = TextEditingController();
  ArgumentStance _selectedStance = ArgumentStance.pro;
  ArgumentConfidence _selectedConfidence = ArgumentConfidence.medium;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_contentController.text.isEmpty) return;

    setState(() => _isSubmitting = true);
    try {
      final argument = ArgumentModel(
        id: '', // Backend should generate ID, but model requires non-null. Empty string is fine for request object usually?
        // Wait, toJson includes ID. If backend generates ID, client shouldn't send one, or backend should ignore it.
        // I'll leave it empty.
        topicId: widget.topicId,
        content: _contentController.text,
        authorId: 'user1', // TODO: Fetch from actual auth
        parentId: widget.parentId,
        stance: _selectedStance,
        confidence: _selectedConfidence,
        depth: 0, // Backend calculates actual depth
        createdAt: DateTime.now(),
      );

      await ref.read(argumentTreeProvider).addArgument(argument);

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Argument submitted!')));
        context.pop();
      }
    } on ApiException catch (e) {
      if (mounted) {
        if (e.statusCode == 429) {
          // Cooldown hit
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('⏳ Slow Down'),
              content: Text(e.message),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('I will reflect'),
                ),
              ],
            ),
          );
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: ${e.message}')));
        }
      }
    } catch (e) {
      if (mounted) {
        // Fallback: If generic catch caught it, check string content
        final errorString = e.toString();
        if (errorString.contains('429')) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('⏳ Slow Down'),
              content: Text(
                'You are posting too fast. Please take a moment to reflect.',
              ), // Fallback text
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('I will reflect'),
                ),
              ],
            ),
          );
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error submitting: $e')));
        }
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Write Argument')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SegmentedButton<ArgumentStance>(
              segments: const [
                ButtonSegment(
                  value: ArgumentStance.pro,
                  label: Text('Pro'),
                  icon: Icon(Icons.thumb_up),
                ),
                ButtonSegment(
                  value: ArgumentStance.con,
                  label: Text('Con'),
                  icon: Icon(Icons.thumb_down),
                ),
              ],
              selected: {_selectedStance},
              onSelectionChanged: (Set<ArgumentStance> newSelection) {
                setState(() {
                  _selectedStance = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  'Confidence:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 16),
                DropdownButton<ArgumentConfidence>(
                  value: _selectedConfidence,
                  items: ArgumentConfidence.values.map((conf) {
                    return DropdownMenuItem(
                      value: conf,
                      child: Text(conf.name.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedConfidence = val);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Present your reasoning...',
                  border: InputBorder.none,
                ),
              ),
            ),
            if (_isSubmitting)
              const CircularProgressIndicator()
            else
              ElevatedButton(onPressed: _submit, child: const Text('Submit')),
          ],
        ),
      ),
    );
  }
}
