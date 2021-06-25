import 'dart:async';
import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../main.dart';
import 'Food.dart';

class FoodStore extends ChangeNotifier {
  Client client;
  bool isLoading = false;

  FoodStore({required this.client});

  List<Food> food = [];

  FoodStore initStore() {
    loadFood();
    return this;
  }

  void loadFood() async {
    isLoading = true;
    notifyListeners();
    Database database = Database(client);
    Response<dynamic> resp =
        await database.listDocuments(collectionId: MyApp.foodColId);
    this.food = List<Food>.from(
        json.decode(resp.toString())["documents"].map((x) => Food.fromJson(x)));
    this.isLoading = false;
    notifyListeners();
  }

  Future<String?> uploadNewFood(Food food) {
    Completer<String?> completer = Completer();
    food.foodId = Uuid().v4();

    Database database = Database(client);
    database.createDocument(
        collectionId: MyApp.foodColId,
        data: food.toJson(),
        read: ["*"]).then((value) {
      print("RESPONSE: " + value.toString());
      this.food.add(food);
      notifyListeners();
      completer.complete(null);
    }).onError((AppwriteException error, stackTrace) {
      print(error.message);
      completer.completeError(error.message.toString());
    });
    return completer.future;
  }

  Future<Food> loadFoodFromId(String scannedFoodDocumentId) async {
    Completer<Food> completer = new Completer();
    Database database = Database(client);
    Response<dynamic> resp = await database.getDocument(
        collectionId: MyApp.foodColId, documentId: scannedFoodDocumentId);

    try {
      completer.complete(Food.fromJson(jsonDecode(resp.toString())));
    } catch (error, stacktrace) {
      completer.completeError("Failed to load");
    }
    return completer.future;
  }

}
