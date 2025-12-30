import '../models/argument_model.dart';
import 'package:debate_app/core/services/api_client.dart';

class ArgumentService {
  Future<List<ArgumentModel>> getArgumentsForTopic(String topicId) async {
    try {
      final response = await ApiClient.get('/arguments?topicId=$topicId');
      if (response is List) {
        return response.map((json) => ArgumentModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      if (e is ApiException && e.statusCode == 404) return [];
      rethrow;
    }
  }

  Future<void> postArgument(ArgumentModel argument) async {
    await ApiClient.post('/arguments', body: argument.toJson());
  }
}
