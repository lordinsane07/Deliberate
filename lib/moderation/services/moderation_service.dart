import 'package:flutter/foundation.dart';
import '../../core/services/api_client.dart';
import '../models/report_model.dart';

class ModerationService {
  static const String _reportEndpoint = '/moderation/reports';

  Future<void> submitReport(ReportModel report) async {
    try {
      await ApiClient.post(
        _reportEndpoint,
        body: report.toJson(),
      );
    } catch (e) {
      debugPrint('Error submiting report: $e');
      rethrow;
    }
  }
}
