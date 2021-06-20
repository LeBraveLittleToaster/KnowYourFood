import 'dart:async';
import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:knowyourfood/main.dart';
import 'package:knowyourfood/stores/Preference.dart';

class PreferenceStore extends ChangeNotifier {
  Client client;
  List<Preference> prefs = [];
  List<PrefRating> userRatings = [];
  bool _isLoading = false;

  PreferenceStore({required this.client});

  bool get isLoading {
    return _isLoading;
  }

  PreferenceStore initPreferences() {
    loadPreferences([]);
    return this;
  }

  Future<List<Preference>> getFilteredPreferences(List<String> prefIds) {
    Database db = Database(client);
    List<String> filters = prefIds.map((e) => "prefId=" + e).toList();
    print(filters);

    var completer = new Completer<List<Preference>>();
    db
        .listDocuments(collectionId: MyApp.prefsColId, filters: filters)
        .then((value) {
      print(value);
      completer.complete(json
          .decode(value.toString())["documents"]
          .map((e) => Preference.fromJson(e)));
    }).onError((error, stackTrace) {
      print(error);
      completer.completeError("Failed to parse or load preferecens");
    });
    return completer.future;
  }

  void loadPreferences(List<String> prefIds) {
    _isLoading = true;
    notifyListeners();
    Database db = Database(client);
    db
        .listDocuments(collectionId: MyApp.prefsColId)
        .then((Response<dynamic> resp) {
      print("prefs: " + resp.toString());
      this.prefs = List<Preference>.from(json
          .decode(resp.toString())["documents"]
          .map((x) => Preference.fromJson(x)));
      if (this.prefs.length > 0) {
        db
            .listDocuments(collectionId: MyApp.prefsRatingColId)
            .then((Response<dynamic> resp) => this.userRatings =
                List<PrefRating>.from(json
                    .decode(resp.toString())["documents"]
                    .map((x) => PrefRating.fromJson(x))))
            .whenComplete(() {
          _isLoading = false;
          this.notifyListeners();
        });
      } else {
        _isLoading = false;
        this.notifyListeners();
      }
    });
  }
}
