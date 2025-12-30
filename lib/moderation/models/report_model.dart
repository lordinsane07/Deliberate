enum ReportReason {
  harassment,
  hateSpeech,
  spam,
  misinformation,
  other,
}

class ReportModel {
  final String id;
  final String reporterId;
  final String reportedContentId; // ID of argument or topic
  final String reportedUserId;
  final ReportReason reason;
  final String? description;
  final DateTime timestamp;

  ReportModel({
    required this.id,
    required this.reporterId,
    required this.reportedContentId,
    required this.reportedUserId,
    required this.reason,
    this.description,
    required this.timestamp,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'] as String,
      reporterId: json['reporterId'] as String,
      reportedContentId: json['reportedContentId'] as String,
      reportedUserId: json['reportedUserId'] as String,
      reason: ReportReason.values.firstWhere(
        (e) => e.toString() == 'ReportReason.${json['reason']}',
        orElse: () => ReportReason.other,
      ),
      description: json['description'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reporterId': reporterId,
      'reportedContentId': reportedContentId,
      'reportedUserId': reportedUserId,
      'reason': reason.toString().split('.').last,
      'description': description,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
