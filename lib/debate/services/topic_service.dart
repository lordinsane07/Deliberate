import '../models/topic_model.dart';
import 'package:debate_app/core/services/api_client.dart';

class TopicService {
  Future<List<TopicModel>> getTopics() async {
    try {
      final response = await ApiClient.get('/topics');
      if (response is List) {
        return response.map((json) => TopicModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
