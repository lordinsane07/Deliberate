class ApiConstants {
  // Auth
  static const String anonymousAuth = '/auth/anonymous';

  // Topics
  static const String todayTopic = '/topics/today';

  // Arguments
  static const String arguments = '/arguments';
  static String replyToArgument(String parentId) =>
      '/arguments/$parentId/reply';

  // Position change
  static const String positionChange = '/position-change';

  // User
  static String debateState(String topicId) =>
      '/me/debate-state/$topicId';

  // Moderation
  static const String report = '/reports';
}
