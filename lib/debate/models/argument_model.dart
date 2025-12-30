enum ArgumentStance { pro, con }

enum ArgumentConfidence { low, medium, high }

class ArgumentModel {
  final String id;
  final String topicId;
  final String content;
  final String authorId;
  final String? parentId;
  final ArgumentStance stance;
  final ArgumentConfidence confidence;
  final int depth;
  final ArgumentStance? switchedFrom;
  final DateTime createdAt;

  ArgumentModel({
    required this.id,
    required this.topicId,
    required this.content,
    required this.authorId,
    this.parentId,
    required this.stance,
    required this.confidence,
    required this.depth,
    this.switchedFrom,
    required this.createdAt,
  });

  factory ArgumentModel.fromJson(Map<String, dynamic> json) {
    return ArgumentModel(
      id: (json['_id'] ?? json['id'] ?? '') as String,
      topicId: json['topicId'] as String,
      content: json['content'] as String,
      authorId: json['authorId'] as String,
      parentId: json['parentId'] as String?,
      stance: ArgumentStance.values.firstWhere(
        (e) => e.toString() == 'ArgumentStance.${json['stance']}',
        orElse: () => ArgumentStance.pro,
      ),
      confidence: ArgumentConfidence.values.firstWhere(
        (e) => e.toString() == 'ArgumentConfidence.${json['confidence']}',
        orElse: () => ArgumentConfidence.medium,
      ),
      depth: (json['depth'] ?? 0) as int,
      switchedFrom: json['switchedFrom'] != null
          ? ArgumentStance.values.firstWhere(
              (e) => e.toString() == 'ArgumentStance.${json['switchedFrom']}',
              orElse: () => ArgumentStance.pro,
            )
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'topicId': topicId,
      'content': content,
      'authorId': authorId,
      'parentId': parentId,
      'stance': stance.toString().split('.').last,
      'confidence': confidence.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
