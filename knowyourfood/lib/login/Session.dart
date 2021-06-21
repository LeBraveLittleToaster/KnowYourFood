class Session {
  String id;
  String userId;
  int expire;
  String provider;
  String providerUid;
  String providerToken;
  String ip;
  String osCode;
  String osName;
  String osVersion;
  String clientType;
  String clientCode;
  String clientName;
  String clientVersion;
  String clientEngine;
  String clientEngineVersion;
  String deviceName;
  String deviceBrand;
  String deviceModel;
  String countryCode;
  String countryName;
  bool current;

  Session(
      {required this.id,
      required this.userId,
      required this.expire,
      required this.provider,
      required this.providerUid,
      required this.providerToken,
      required this.ip,
      required this.osCode,
      required this.osName,
      required this.osVersion,
      required this.clientType,
      required this.clientCode,
      required this.clientName,
      required this.clientVersion,
      required this.clientEngine,
      required this.clientEngineVersion,
      required this.deviceName,
      required this.deviceBrand,
      required this.deviceModel,
      required this.countryCode,
      required this.countryName,
      required this.current});

  Session.fromJson(Map<String, dynamic> json)
      : id = json[r'$id'] ?? "",
        userId = json['userId'] ?? "",
        expire = json['expire'] ?? -1,
        provider = json['provider'] ?? "",
        providerUid = json['providerUid']?? "",
        providerToken = json['providerToken']?? "",
        ip = json['ip']?? "",
        osCode = json['osCode']?? "",
        osName = json['osName']?? "",
        osVersion = json['osVersion']?? "",
        clientType = json['clientType']?? "",
        clientCode = json['clientCode']?? "",
        clientName = json['clientName']?? "",
        clientVersion = json['clientVersion']?? "",
        clientEngine = json['clientEngine']?? "",
        clientEngineVersion = json['clientEngineVersion']?? "",
        deviceName = json['deviceName']?? "",
        deviceBrand = json['deviceBrand']?? "",
        deviceModel = json['deviceModel']?? "",
        countryCode = json['countryCode']?? "",
        countryName = json['countryName']?? "",
        current = json['current']?? "";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[r'$id'] = this.id;
    data['userId'] = this.userId;
    data['expire'] = this.expire;
    data['provider'] = this.provider;
    data['providerUid'] = this.providerUid;
    data['providerToken'] = this.providerToken;
    data['ip'] = this.ip;
    data['osCode'] = this.osCode;
    data['osName'] = this.osName;
    data['osVersion'] = this.osVersion;
    data['clientType'] = this.clientType;
    data['clientCode'] = this.clientCode;
    data['clientName'] = this.clientName;
    data['clientVersion'] = this.clientVersion;
    data['clientEngine'] = this.clientEngine;
    data['clientEngineVersion'] = this.clientEngineVersion;
    data['deviceName'] = this.deviceName;
    data['deviceBrand'] = this.deviceBrand;
    data['deviceModel'] = this.deviceModel;
    data['countryCode'] = this.countryCode;
    data['countryName'] = this.countryName;
    data['current'] = this.current;
    return data;
  }

  
}
