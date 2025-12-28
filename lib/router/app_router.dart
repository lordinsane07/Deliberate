import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: Routes.onboarding,
      builder: (context, state) {
        return const Scaffold(
          body: Center(
            child: Text('Router OK'),
          ),
        );
      },
    ),
  ],
);
