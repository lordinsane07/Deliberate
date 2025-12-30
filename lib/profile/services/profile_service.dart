import 'package:flutter/foundation.dart';
import '../../core/services/api_client.dart';
import '../models/stance_history_model.dart';

class ProfileService {
  // Placeholder endpoints
  static const String _profileEndpoint = '/users/profile';
  static const String _historyEndpoint = '/users/history';

  Future<Map<String, dynamic>> getUserProfile(String userId) async {
    try {
      final response = await ApiClient.get('$_profileEndpoint/$userId');
      return response;
    } catch (e) {
      debugPrint('Error fetching profile: $e');
      return {};
    }
  }

  Future<List<StanceHistoryModel>> getStanceHistory(String userId) async {
    try {
      // Assuming GET /users/history?userId=... or similar
      final response = await ApiClient.get('$_historyEndpoint/$userId');
       final List<dynamic> data = response['data'] ?? [];
      return data.map((json) => StanceHistoryModel.fromJson(json)).toList();
    } catch (e) {
      debugPrint('Error fetching history: $e');
      return [];
    }
  }
}
