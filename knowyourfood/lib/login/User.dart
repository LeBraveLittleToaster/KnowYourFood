class User {
  String id;
  String name;
  int registration;
  int status;
  int passwordUpdate;
  String email;
  bool emailVerification;

  User(
      {required this.id,
      required this.name,
      required this.registration,
      required this.status,
      required this.passwordUpdate,
      required this.email,
      required this.emailVerification});

  User.fromJson(Map<String, dynamic> json):
    id = json[r'$id'],
    name = json['name'],
    registration = json['registration'],
    status = json['status'],
    passwordUpdate = json['passwordUpdate'],
    email = json['email'],
    emailVerification = json['emailVerification'];
  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[r'$id'] = this.id;
    data['name'] = this.name;
    data['registration'] = this.registration;
    data['status'] = this.status;
    data['passwordUpdate'] = this.passwordUpdate;
    data['email'] = this.email;
    data['emailVerification'] = this.emailVerification;
    return data;
  }
}