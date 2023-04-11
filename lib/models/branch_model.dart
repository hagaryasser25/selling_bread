class Branch {
  Branch({
    String? id,
    String? address,
    String? phoneNumber,
  }) {
    _id = id;
    _address = address;
    _phoneNumber = phoneNumber;
  }

  Branch.fromJson(dynamic json) {
    _id = json['id'];
    _address = json['address'];
    _phoneNumber = json['phoneNumber'];
  }

  String? _id;
  String? _address;
  String? _phoneNumber;

  String? get id => _id;
  String? get address => _address;
  String? get phoneNumber => _phoneNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['address'] = _address;
    map['phoneNumber'] = _phoneNumber;

    return map;
  }
}
