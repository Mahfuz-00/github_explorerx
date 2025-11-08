import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Common/Services/search_history_service.dart';
import '../../Core/Config/Constants/constants.dart';
import '../../Core/Navigations/app_router.dart';
import '../Getx/theme_controller.dart';

class UsernamePage extends StatefulWidget {
  const UsernamePage({super.key});

  @override
  State<UsernamePage> createState() => _UsernamePageState();
}

class _UsernamePageState extends State<UsernamePage> {
  final _controller = TextEditingController();
  final _searchHistory = <String>[].obs;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final history = await SearchHistoryService.getHistory();
    _searchHistory.assignAll(history);
  }

  void _onContinue() async {
    final username = _controller.text.trim();
    if (username.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a GitHub username',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      return;
    }

    await SearchHistoryService.addUsername(username);
    Get.toNamed(AppRouter.home, parameters: {'username': username});
  }

  void _onSuggestionTap(String username) {
    _controller.text = username;
    _onContinue();
  }

  void _removeFromHistory(String username) async {
    await SearchHistoryService.remove(username: username);
    _searchHistory.remove(username);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          AppConstants.appName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => Get.find<ThemeController>().toggleTheme(),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              // Logo
              Image.asset(
                'Assets/Images/github-logo.png',
                width: 100,
                height: 100,
                color: isDark ? Colors.white : Colors.black,
              ),
              const SizedBox(height: 32),

              // Title
              Text(
                'Welcome to GitHub ExplorerX',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // Subtitle
              Text(
                'Enter a GitHub username to view their repositories',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // TextField
              TextField(
                controller: _controller,
                textInputAction: TextInputAction.go,
                onSubmitted: (_) => _onContinue(),
                decoration: InputDecoration(
                  labelText: 'GitHub Username',
                  hintText: 'e.g. mahfuz-00',
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: isDark
                      ? Colors.white.withOpacity(0.05)
                      : Colors.black.withOpacity(0.03),
                ),
              ),
              const SizedBox(height: 16),

              // Recent Searches
              Obx(() {
                if (_searchHistory.isEmpty) return const SizedBox();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recent Searches',
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _searchHistory.map((name) {
                        return GestureDetector(
                          onTap: () => _onSuggestionTap(name),
                          child: Chip(
                            label: Text(name),
                            avatar: const Icon(Icons.history, size: 16),
                            backgroundColor:
                            theme.colorScheme.surfaceVariant.withOpacity(0.6),
                            labelStyle: theme.textTheme.bodySmall,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                            deleteIcon: const Icon(Icons.close, size: 16),
                            onDeleted: () => _removeFromHistory(name),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              }),

              // Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onContinue,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}