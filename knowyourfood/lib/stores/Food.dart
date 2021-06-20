import 'package:knowyourfood/stores/Preference.dart';

class Food {
  String foodId;
  String brandName;
  String name;
  String description;
  List<PrefStatement> prefs;

  Food(
      {required this.foodId,
      required this.brandName,
      required this.name,
      required this.description,
      required this.prefs});

  Food.fromJson(Map<String, dynamic> json)
      : foodId = json['foodId'],
        name = json['name'],
        brandName = json['brandName'],
        description = json['description'],
        prefs = json['prefs'] != null
            ? List.from(json['prefs'].map((x) => Preference.fromJson(x)))
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
