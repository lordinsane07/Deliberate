import 'argument_model.dart';

class PositionChangeModel {
  final String id;
  final String userId;
  final String topicId;
  final ArgumentStance previousStance;
  final ArgumentStance newStance;
  final String reason;
  final DateTime timestamp;

  PositionChangeModel({
    required this.id,
    required this.userId,
    required this.topicId,
    required this.previousStance,
    required this.newStance,
    required this.reason,
    required this.timestamp,
  });

  factory PositionChangeModel.fromJson(Map<String, dynamic> json) {
    return PositionChangeModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      topicId: json['topicId'] as String,
      previousStance: ArgumentStance.values.firstWhere(
          (e) => e.toString() == 'ArgumentStance.${json['previousStance']}'),
      newStance: ArgumentStance.values.firstWhere(
          (e) => e.toString() == 'ArgumentStance.${json['newStance']}'),
      reason: json['reason'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'topicId': topicId,
      'previousStance': previousStance.toString().split('.').last,
      'newStance': newStance.toString().split('.').last,
      'reason': reason,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
