import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:knowyourfood/stores/Preference.dart';

import 'Food.dart';

class PreferenceStore extends ChangeNotifier {
  Client client;
  List<Food> availableFood = [];
  List<Preference> userPrefs = [];
  bool _isLoading = false;
  
  PreferenceStore({required this.client});

  bool get isLoading {
    return _isLoading;
  }

  PreferenceStore initPreferences() {
    loadPreferences();
    return this;
  }

  void loadPreferences() {
    _isLoading = true;
    notifyListeners();
  }

  
}