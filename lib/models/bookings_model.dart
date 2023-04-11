
class Booking {
  Booking({
    String? id,
    String? branchName,
    String? imageUrl,
    String? userName,
    String? userPhone,
    String? userAddress,
    String? name,
    int? price,
    int? total,
    String? amount,
  }) {
    _id = id;
    _branchName = branchName;
    _imageUrl = imageUrl;
    _userName = userName;
    _userPhone = userPhone;
    _userAddress = userAddress;
    _name = name;
    _price = price;
    _total = total;
    _amount = amount;
  }

  Booking.fromJson(dynamic json) {
    _id = json['id'];
    _branchName = json['branchName'];
    _userName = json['userName'];
    _imageUrl = json['imageUrl'];
    _userPhone = json['userPhone'];
    _userAddress = json['userAddress'];
    _name = json['name'];
    _price = json['price'];
    _total = json['total'];
    _amount = json['amount'];
  }

  String? _id;
  String? _branchName;
  String? _userName;
  String? _imageUrl;
  String? _userPhone;
  String? _userAddress;
  String? _name;
  int? _price;
  int? _total;
  String? _amount;

  String? get id => _id;
  String? get branchName => _branchName;
  String? get userName => _userName;
  String? get userAddress => _userAddress;
  String? get imageUrl => _imageUrl;
  String? get userPhone => _userPhone;
  String? get name => _name;
  int? get price => _price;
  int? get total => _total;
  String? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['branchName'] = _branchName;
    map['userName'] = _userName;
    map['imageUrl'] = _imageUrl;
    map['userPhone'] = _userPhone;
    map['userAddress'] = _userAddress;
    map['name'] = _name;
    map['price'] = _price;
    map['total'] = _total;
    map['amount'] = _amount;

    return map;
  }
}