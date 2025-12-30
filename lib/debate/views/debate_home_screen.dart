import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../router/route_names.dart';
import '../providers/topic_provider.dart';

class DebateHomeScreen extends ConsumerStatefulWidget {
  const DebateHomeScreen({super.key});

  @override
  ConsumerState<DebateHomeScreen> createState() => _DebateHomeScreenState();
}

class _DebateHomeScreenState extends ConsumerState<DebateHomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(topicProvider).loadTopics();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(topicProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Deliberate')),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => ref.read(topicProvider).loadTopics(),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: provider.topics.length,
                itemBuilder: (context, index) {
                  final topic = provider.topics[index];
                  return _buildTopicCard(
                    context,
                    topic.id,
                    topic.title,
                    topic.description,
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Create Topic feature coming soon!')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTopicCard(
    BuildContext context,
    String id,
    String title,
    String subtitle,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          context.go(Routes.topicDetail, extra: id);
        },
      ),
    );
  }
}
