class Preference {
  String name;
  String prefId;
  String description;

  Preference(
      {required this.name, required this.prefId, required this.description});

  Preference.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? "",
        prefId = json['topicId'] ?? "",
        description = json['userId'] ?? "";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['topicId'] = this.prefId;
    data['userId'] = this.description;
    return data;
  }
}

class PrefRating {
  String prefId;
  String userId;
  int rating;

  PrefRating(
      {required this.prefId, required this.userId, required this.rating});

  PrefRating.fromJson(Map<String, dynamic> json)
      : prefId = json['prefId'] ?? "",
        userId = json['userId'] ?? "",
        rating = json['rating'] ?? -1;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prefId'] = this.prefId;
    data['userId'] = this.userId;
    data['rating'] = this.rating;
    return data;
  }
}

class PrefStatement {
  String prefId;
  String foodId;
  int rating;
  String statement;

  PrefStatement(
      {required this.prefId,
      required this.foodId,
      required this.rating,
      required this.statement});

  PrefStatement.fromJson(Map<String, dynamic> json)
      : prefId = json['prefId'] ?? "",
        foodId = json['foodId'] ?? "",
        rating = json['rating'] ?? -1,
        statement = json['statement'] ?? "";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prefId'] = this.prefId;
    data['foodId'] = this.foodId;
    data['rating'] = this.rating;
    data['statement'] = this.statement;
    return data;
  }
}