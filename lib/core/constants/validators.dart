class Validators {
  /// Alias / nickname validation
  static String? validateAlias(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Alias cannot be empty';
    }

    final trimmed = value.trim();

    if (trimmed.length < 3) {
      return 'Alias must be at least 3 characters';
    }

    if (trimmed.length > 20) {
      return 'Alias must be under 20 characters';
    }

    final validPattern = RegExp(r'^[a-zA-Z0-9_]+$');
    if (!validPattern.hasMatch(trimmed)) {
      return 'Only letters, numbers, and _ allowed';
    }

    return null; // valid
  }

  /// Argument content validation
  static String? validateArgument(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Argument cannot be empty';
    }

    final trimmed = value.trim();

    if (trimmed.length < 20) {
      return 'Argument is too short';
    }

    if (trimmed.length > 300) {
      return 'Argument exceeds 300 characters';
    }

    return null; // valid
  }

  /// Opponent summary validation
  static String? validateSummary(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Summary is required';
    }

    if (value.trim().length < 10) {
      return 'Summary is too short';
    }

    return null;
  }
}
