import '../constants/time_constants.dart';

class CooldownUtils {
  /// Returns true if current time is before [unlockAt]
  static bool isInCooldown(DateTime unlockAt) {
    return DateTime.now().isBefore(unlockAt);
  }

  /// Returns remaining cooldown duration (never negative)
  static Duration remainingTime(DateTime unlockAt) {
    final diff = unlockAt.difference(DateTime.now());
    return diff.isNegative ? Duration.zero : diff;
  }

  /// Returns the next cooldown duration based on reply count
  static Duration cooldownForReplyCount(int replyCount) {
    if (replyCount <= 1) {
      return TimeConstants.firstReplyCooldown;
    }
    return TimeConstants.secondReplyCooldown;
  }
}
