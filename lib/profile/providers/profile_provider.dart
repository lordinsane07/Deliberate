import 'package:flutter/foundation.dart';
import '../../auth/models/user_model.dart';
import '../models/stance_history_model.dart';
import '../services/profile_service.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileService _profileService;
  List<StanceHistoryModel> _history = [];
  bool _isLoading = false;

  ProfileProvider(this._profileService);

  List<StanceHistoryModel> get history => _history;
  bool get isLoading => _isLoading;

  Future<void> loadProfile(String userId) async {
    _isLoading = true;
    notifyListeners();
    try {
      // Load user details if needed, for now just history
      _history = await _profileService.getStanceHistory(userId);
    } catch (e) {
      debugPrint('Error loading profile: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
