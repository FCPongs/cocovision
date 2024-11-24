import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  // Default language is English
  bool _isEnglish = true;

  bool get isEnglish => _isEnglish;

  // Function to toggle the language
  void toggleLanguage() {
    _isEnglish = !_isEnglish;
    notifyListeners(); // Notify widgets about the language change
  }
}
