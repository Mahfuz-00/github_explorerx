import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryService {
  static const _key = 'search_history';
  static const _max = 10;

  static Future<void> addUsername(String name) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    list.remove(name);
    list.insert(0, name);
    if (list.length > _max) list.removeLast();
    await prefs.setStringList(_key, list);
  }

  static Future<List<String>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  static Future<void> remove({required String username}) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    list.remove(username);
    await prefs.setStringList(_key, list);
  }
}