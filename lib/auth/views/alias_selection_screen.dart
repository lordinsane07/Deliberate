import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../router/route_names.dart';

class AliasSelectionScreen extends StatefulWidget {
  const AliasSelectionScreen({super.key});

  @override
  State<AliasSelectionScreen> createState() => _AliasSelectionScreenState();
}

class _AliasSelectionScreenState extends State<AliasSelectionScreen> {
  final _aliasController = TextEditingController();

  @override
  void dispose() {
    _aliasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Your Alias')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text('Pick a unique alias for your debates.'),
            const SizedBox(height: 24),
            TextField(
              controller: _aliasController,
              decoration: const InputDecoration(
                labelText: 'Alias',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                if (_aliasController.text.isNotEmpty) {
                  // TODO: Call actual auth provider to save alias
                  // Mocking network delay
                  await Future.delayed(const Duration(seconds: 1));
                  if (context.mounted) {
                    context.go(Routes.debateHome);
                  }
                }
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
