import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
              const SizedBox(height: 16),
              const Text(
                'Alias', // Placeholder: Get from AuthProvider
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Debater Level: Novice'),
              const SizedBox(height: 24),
              const Divider(),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Stance History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
              // Placeholder for history list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return const ListTile(
                    title: Text('Topic Title Placeholder'),
                    subtitle: Text('Stance: PRO • Date: 2023-10-27'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
