import 'dart:convert';

import 'package:knowyourfood/stores/Preference.dart';

class Food {
  String id;
  String foodId;
  String brandName;
  String name;
  String description;
  List<PrefStatement> prefs;

  Food(
      {required this.id,
      required this.foodId,
      required this.brandName,
      required this.name,
      required this.description,
      required this.prefs});

  Food.fromJson(Map<String, dynamic> jsonData)
      : id = jsonData[r'$id'] ?? "",
      foodId = jsonData['foodId'],
        name = jsonData['name'],
        brandName = jsonData['brandName'],
        description = jsonData['description'],
        prefs = jsonData['prefs'] != null
            ? List<PrefStatement>.from(jsonData['prefs'].map((x) {
                return PrefStatement.fromJson(x.runtimeType == String ? jsonDecode(x) : x);
              }))
            : [];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['foodId'] = foodId;
    data['brandName'] = brandName;
    data['description'] = this.description;
    data['name'] = this.name;
    data['prefs'] = this.prefs.map((v) => v.toJson()).toList();
    return data;
  }
}
