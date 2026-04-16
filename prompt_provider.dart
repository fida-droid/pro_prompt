import 'package:flutter/material.dart';
import '../models/prompt.dart';
import '../services/database_service.dart';

class PromptProvider with ChangeNotifier {
  List<Prompt> _prompts = [];
  String _searchQuery = '';
  Locale _locale = const Locale('en');
  bool _isDarkMode = true;

  List<Prompt> get prompts => _prompts.where((p) => 
    p.title.toLowerCase().contains(_searchQuery.toLowerCase()) || 
    p.text.toLowerCase().contains(_searchQuery.toLowerCase())
  ).toList();

  List<Prompt> get favorites => _prompts.where((p) => p.isFavorite).toList();
  Locale get locale => _locale;
  bool get isDarkMode => _isDarkMode;

  Future<void> loadPrompts() async {
    _prompts = await DatabaseService().getPrompts();
    if (_prompts.isEmpty) {
      _prompts = _getInitialData();
      for (var p in _prompts) {
        await DatabaseService().insertPrompt(p);
      }
    }
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> toggleFavorite(String id) async {
    final index = _prompts.indexWhere((p) => p.id == id);
    if (index != -1) {
      _prompts[index].isFavorite = !_prompts[index].isFavorite;
      await DatabaseService().updateFavorite(id, _prompts[index].isFavorite);
      notifyListeners();
    }
  }

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  List<Prompt> _getInitialData() {
    return [
      Prompt(
        id: '1',
        title: 'Cyberpunk Portrait',
        text: 'A hyper-realistic portrait of a cyberpunk character with neon lights, 8k resolution, cinematic lighting.',
        imageUrl: 'https://picsum.photos/seed/cyber/400/300',
        category: 'Image Generation',
      ),
      Prompt(
        id: '2',
        title: 'Viral TikTok Hook',
        text: 'Write a viral TikTok hook for a new tech gadget that focuses on solving a common daily problem.',
        imageUrl: 'https://picsum.photos/seed/tiktok/400/300',
        category: 'TikTok Prompts',
      ),
      Prompt(
        id: '3',
        title: 'SEO Blog Post',
        text: 'Write a 1000-word SEO-optimized blog post about the future of remote work in 2024.',
        imageUrl: 'https://picsum.photos/seed/blog/400/300',
        category: 'Content Writing',
      ),
      Prompt(
        id: '4',
        title: 'Upwork Proposal',
        text: 'Create a winning Upwork proposal for a mobile app development project.',
        imageUrl: 'https://picsum.photos/seed/freelance/400/300',
        category: 'Freelancing',
      ),
      Prompt(
        id: '5',
        title: 'SaaS Business Idea',
        text: 'Generate 5 unique SaaS business ideas for the healthcare industry using AI.',
        imageUrl: 'https://picsum.photos/seed/business/400/300',
        category: 'Business Ideas',
      ),
    ];
  }
}
