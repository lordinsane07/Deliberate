import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';

// Views
import '../auth/views/onboarding_screen.dart';
import '../auth/views/alias_selection_screen.dart';
import '../debate/views/debate_home_screen.dart';
import '../debate/views/topic_detail_screen.dart';
import '../debate/views/stance_selection_screen.dart';
import '../debate/views/argument_tree_screen.dart';
import '../debate/views/write_argument_screen.dart';
import '../debate/views/locked_state_screen.dart';
import '../profile/views/profile_screen.dart';
import '../moderation/views/report_screen.dart';
import '../debate/views/summary_check_screen.dart';

final appRouter = GoRouter(
  initialLocation: Routes.onboarding,
  routes: [
    GoRoute(
      path: Routes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: Routes.aliasSelection,
      builder: (context, state) => const AliasSelectionScreen(),
    ),
    GoRoute(
      path: Routes.debateHome,
      builder: (context, state) => const DebateHomeScreen(),
    ),
    GoRoute(
      path: Routes.topicDetail,
      builder: (context, state) {
        // Assuming we pass ID as query param or part of path?
        // Adapting previous logic which expected arguments object or strictly typed param
        // For GoRouter, usually we use path params: /topic/:id
        // But for now, let's assume valid state.extra or query params if I change route names
        final id = state.extra as String?;
        return TopicDetailScreen(topicId: id ?? 'error');
      },
    ),
    GoRoute(
      path: Routes.stanceSelection,
      builder: (context, state) {
        final id = state.extra as String?;
        return StanceSelectionScreen(topicId: id ?? 'error');
      },
    ),
    GoRoute(
      path: Routes.argumentTree,
      builder: (context, state) {
        final id = state.extra as String?;
        return ArgumentTreeScreen(topicId: id ?? 'error');
      },
    ),
    GoRoute(
      path: Routes.writeArgument,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return WriteArgumentScreen(
          topicId: extra?['topicId'] ?? 'error',
          parentId: extra?['parentId'],
        );
      },
    ),
    GoRoute(
      path: Routes.lockedState,
      builder: (context, state) {
        final unlockTime = state.extra as DateTime? ?? DateTime.now();
        return LockedStateScreen(unlockTime: unlockTime);
      },
    ),
    GoRoute(
      path: Routes.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: Routes.report,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return ReportScreen(
          contentId: extra?['contentId'] ?? '',
          reportedUserId: extra?['reportedUserId'] ?? '',
        );
      },
    ),
    GoRoute(
      path: Routes.summaryCheck,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return SummaryCheckScreen(
          topicId: extra?['topicId'] ?? '',
          parentId: extra?['parentId'] ?? '',
          parentContent: extra?['parentContent'] ?? '',
        );
      },
    ),
  ],
);
