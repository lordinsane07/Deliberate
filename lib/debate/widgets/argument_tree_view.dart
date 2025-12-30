import 'package:flutter/material.dart';
import '../models/argument_model.dart';
import 'argument_node_widget.dart';

class ArgumentTreeView extends StatelessWidget {
  final List<ArgumentModel> arguments;
  final Function(ArgumentModel) onReply;

  const ArgumentTreeView({
    super.key,
    required this.arguments,
    required this.onReply,
  });

  @override
  Widget build(BuildContext context) {
    final sortedNodes = _buildThreadedList(arguments);

    return ListView.builder(
      itemCount: sortedNodes.length,
      itemBuilder: (context, index) {
        final node = sortedNodes[index];
        return Padding(
          padding: EdgeInsets.only(left: node.depth * 16.0),
          child: ArgumentNodeWidget(
            argument: node.argument,
            onReply: () => onReply(node.argument),
          ),
        );
      },
    );
  }

  List<_ThreadedNode> _buildThreadedList(List<ArgumentModel> flatList) {
    if (flatList.isEmpty) return [];

    final Map<String, List<ArgumentModel>> childrenMap = {};
    for (var arg in flatList) {
      if (arg.parentId != null) {
        childrenMap.putIfAbsent(arg.parentId!, () => []).add(arg);
      }
    }

    // Sort children by date (oldest first? or newest?) - usually oldest first for reading flow
    for (var key in childrenMap.keys) {
      childrenMap[key]!.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    }

    final List<_ThreadedNode> result = [];

    // Roots are those with no parent (or parent not found in list, though that shouldn't happen)
    // Actually, `parentId` can be null.
    final roots = flatList.where((arg) => arg.parentId == null).toList()
      ..sort(
        (a, b) => b.createdAt.compareTo(a.createdAt),
      ); // Newest discussions at top

    void traverse(ArgumentModel current, int depth) {
      result.add(_ThreadedNode(current, depth));
      if (childrenMap.containsKey(current.id)) {
        for (var child in childrenMap[current.id]!) {
          traverse(child, depth + 1);
        }
      }
    }

    for (var root in roots) {
      traverse(root, 0);
    }

    return result;
  }
}

class _ThreadedNode {
  final ArgumentModel argument;
  final int depth;

  _ThreadedNode(this.argument, this.depth);
}
