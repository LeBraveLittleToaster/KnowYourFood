import 'dart:async';
import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:knowyourfood/login/Session.dart';
import 'package:knowyourfood/login/User.dart';
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
    Completer<List<Preference>> completer = new Completer();
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

  void addOrUpdateRating(int rating, String prefId) async {
    String userId = await getUserId();
    Database db = new Database(client);
    try {
      print("Updating document");
      PrefRating prefR =
          userRatings.firstWhere((element) => element.prefId == prefId);
      db.updateDocument(
          collectionId: MyApp.prefsRatingColId,
          documentId: prefR.$id,
          data: {"rating": rating});
      prefR.rating = rating;
      notifyListeners();
    } catch (error) {
      print("Creating document");
      Response<dynamic> resp = await db.createDocument(
          collectionId: MyApp.prefsRatingColId,
          data: {"prefId": prefId, "userId": userId, "rating": rating} );
      PrefRating prefR = PrefRating.fromJson(json.decode(resp.toString()));
      userRatings.add(prefR);
      notifyListeners();
    }
  }

  Future<String> getUserId() async {
    Account account = new Account(client);
    Response<dynamic> resp = await account.get();
    print(resp);
    User user = User.fromJson(json.decode(resp.toString()));
    return user.id;
  }
}
