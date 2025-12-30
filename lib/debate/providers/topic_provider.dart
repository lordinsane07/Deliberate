import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../services/topic_service.dart';
import '../models/topic_model.dart';

final topicServiceProvider = Provider((ref) => TopicService());

final topicProvider = ChangeNotifierProvider((ref) {
  final service = ref.watch(topicServiceProvider);
  return TopicProvider(service);
});

class TopicProvider extends ChangeNotifier {
  final TopicService _topicService;
  List<TopicModel> _topics = [];
  bool _isLoading = false;

  TopicProvider(this._topicService);

  List<TopicModel> get topics => _topics;
  bool get isLoading => _isLoading;

  Future<void> loadTopics() async {
    _isLoading = true;
    notifyListeners();
    try {
      _topics = await _topicService.getTopics();
    } catch (e) {
      debugPrint('Error loading topics: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
