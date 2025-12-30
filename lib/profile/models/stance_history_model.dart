import '../../debate/models/argument_model.dart';

class StanceHistoryModel {
  final String id;
  final String userId;
  final String topicId;
  final String topicTitle;
  final ArgumentStance stance;
  final DateTime joinedAt;
  final DateTime? leftAt;

  StanceHistoryModel({
    required this.id,
    required this.userId,
    required this.topicId,
    required this.topicTitle,
    required this.stance,
    required this.joinedAt,
    this.leftAt,
  });

  factory StanceHistoryModel.fromJson(Map<String, dynamic> json) {
    return StanceHistoryModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      topicId: json['topicId'] as String,
      topicTitle: json['topicTitle'] as String,
      stance: ArgumentStance.values.firstWhere(
        (e) => e.toString() == 'ArgumentStance.${json['stance']}',
        orElse: () => ArgumentStance.pro,
      ),
      joinedAt: DateTime.parse(json['joinedAt'] as String),
      leftAt: json['leftAt'] != null ? DateTime.parse(json['leftAt'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'topicId': topicId,
      'topicTitle': topicTitle,
      'stance': stance.toString().split('.').last,
      'joinedAt': joinedAt.toIso8601String(),
      'leftAt': leftAt?.toIso8601String(),
    };
  }
}
