import 'package:flutter/material.dart';
import '../models/argument_model.dart';

class ArgumentNodeWidget extends StatelessWidget {
  final ArgumentModel argument;
  final VoidCallback onReply;

  const ArgumentNodeWidget({
    super.key,
    required this.argument,
    required this.onReply,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Chip(
                label: Text(
                  argument.stance == ArgumentStance.pro ? 'PRO' : 'CON',
                ),
                backgroundColor: argument.stance == ArgumentStance.pro
                    ? Colors.green[100]
                    : Colors.red[100],
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),

                child: Text(
                  '${argument.confidence.name.toUpperCase()} CONFIDENCE',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: _getConfidenceColor(argument.confidence),
                  ),
                ),
              ),
              if (argument.switchedFrom != null) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.purple.shade200),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.change_circle_outlined,
                        size: 12,
                        color: Colors.purple.shade800,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'DELTA',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple.shade800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const Spacer(),
              Text(
                'By ${argument.authorId}', // Use ID for now, later fetch alias
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(argument.content),
          const SizedBox(height: 8),
          if (argument.depth < 6)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: onReply,
                icon: const Icon(Icons.reply, size: 16),
                label: const Text('Reply'),
              ),
            ),
        ],
      ),
    );
  }

  Color _getConfidenceColor(ArgumentConfidence confidence) {
    switch (confidence) {
      case ArgumentConfidence.high:
        return Colors.blue.shade800;
      case ArgumentConfidence.medium:
        return Colors.grey.shade800;
      case ArgumentConfidence.low:
        return Colors.grey.shade500;
    }
  }
}
