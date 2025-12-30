import 'package:flutter/material.dart';

class OpponentSummaryCard extends StatelessWidget {
  final String opponentId; // In future, use model
  final int argumentCount;

  const OpponentSummaryCard({
    super.key,
    required this.opponentId,
    required this.argumentCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: Text('Opponent: $opponentId'), // Placeholder
        subtitle: Text('Contributed $argumentCount arguments'),
      ),
    );
  }
}
