import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../services/argument_service.dart';
import '../models/argument_model.dart';

final argumentServiceProvider = Provider((ref) => ArgumentService());

final argumentTreeProvider = ChangeNotifierProvider((ref) {
  final service = ref.watch(argumentServiceProvider);
  return ArgumentTreeProvider(service);
});

class ArgumentTreeProvider extends ChangeNotifier {
  final ArgumentService _argumentService;
  List<ArgumentModel> _arguments = [];
  bool _isLoading = false;

  ArgumentTreeProvider(this._argumentService);

  List<ArgumentModel> get arguments => _arguments;
  bool get isLoading => _isLoading;

  Future<void> loadArguments(String topicId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _arguments = await _argumentService.getArgumentsForTopic(topicId);
    } catch (e) {
      debugPrint('Error loading arguments: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addArgument(ArgumentModel argument) async {
    try {
      await _argumentService.postArgument(argument);
      await loadArguments(argument.topicId);
    } catch (e) {
      debugPrint('Error adding argument: $e');
      rethrow;
    }
  }
}
