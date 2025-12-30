import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../router/route_names.dart';

import '../widgets/argument_tree_view.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/argument_tree_provider.dart';

class ArgumentTreeScreen extends ConsumerStatefulWidget {
  final String topicId;

  const ArgumentTreeScreen({super.key, required this.topicId});

  @override
  ConsumerState<ArgumentTreeScreen> createState() => _ArgumentTreeScreenState();
}

class _ArgumentTreeScreenState extends ConsumerState<ArgumentTreeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch arguments when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(argumentTreeProvider).loadArguments(widget.topicId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(argumentTreeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Debate Tree')),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ArgumentTreeView(
              arguments: provider.arguments,
              onReply: (argument) {
                // Navigate to Summary Check first!
                context.push(
                  Routes.summaryCheck,
                  extra: {
                    'topicId': widget.topicId,
                    'parentId': argument.id,
                    'parentContent': argument.content,
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(
            Routes.writeArgument,
            extra: {'topicId': widget.topicId},
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
