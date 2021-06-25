class Preference {
  String id;
  String name;
  String prefId;
  String description;
  String category;

  Preference(
      {required this.id,
      required this.name,
      required this.prefId,
      required this.description,
      required this.category});

  Preference.fromJson(Map<String, dynamic> json)
      : id = json[r'$id'] ?? "",
        name = json['name'] ?? "",
        prefId = json['prefId'] ?? "",
        description = json['description'] ?? "",
        category = json['category'] ?? "";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['topicId'] = this.prefId;
    data['description'] = this.description;
    data['category'] = this.category;
    return data;
  }
}

class PrefRating {
  String $id;
  String prefId;
  String userId;
  int rating;

  PrefRating(
      {required this.$id,
      required this.prefId,
      required this.userId,
      required this.rating});

  PrefRating.fromJson(Map<String, dynamic> json)
      : $id = json[r'$id'] ?? "",
        prefId = json['prefId'] ?? "",
        userId = json['userId'] ?? "",
        rating = json['rating'] ?? -1;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[r'$id'] = this.$id;
    data['prefId'] = this.prefId;
    data['userId'] = this.userId;
    data['rating'] = this.rating;
    return data;
  }
}

class PrefStatement {
  String id;
  String prefId;
  int rating;
  String statement;
  String prefName;

  PrefStatement(
      {required this.id,
      required this.prefId,
      required this.rating,
      required this.statement,
      required this.prefName});

  PrefStatement.fromJson(Map<String, dynamic> json)
      : id = json[r'$id'] ?? "",
        prefId = json['prefId'] ?? "",
        rating = json['rating'] ?? -1,
        statement = json['statement'] ?? "",
        prefName = json['prefName'] ?? "";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prefId'] = this.prefId;
    data['rating'] = this.rating;
    data['statement'] = this.statement;
    data['prefName'] = this.prefName;
    return data;
  }
}
