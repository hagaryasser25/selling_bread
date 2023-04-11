class Cart {
  Cart({
    String? name,
    int? price,
    int? stock,
    String? imageUrl,
    int? amount,
    int? total,
    String? id,
    String? productId,
    String? branchName,
    String? userName,
    String? userPhone,
  }) {
    _name = name;
    _price = price;
    _stock = stock;
    _imageUrl = imageUrl;
    _amount = amount;
    _total = total;
    _id = id;
    _productId = productId;
    _branchName = branchName;
    _userName = userName;
    _userPhone = userPhone;
  }

  Cart.fromJson(dynamic json) {
    _name = json['description'];
    _price = json['price'];
    _stock = json['stock'];
    _imageUrl = json['imageUrl'];
    _amount = json['amount'];
    _total = json['total'];
    _id = json['id'];
    _productId = json['productId'];
    _branchName = json['branchName'];
    _userName = json['userName'];
    _userPhone = json['userPhone'];
  }

  String? _name;
  int? _price;
  int? _stock;
  String? _imageUrl;
  int? _amount;
  int? _total;
  String? _id;
  String? _productId;
  String? _branchName;
  String? _userName;
  String? _userPhone;

  String? get name => _name;
  int? get price => _price; 
  int? get stock => _stock;
  String? get imageUrl => _imageUrl;
  int? get amount => _amount;
  int? get total => _total;
  String? get id => _id;
  String? get productId => _productId;
  String? get branchName => _branchName;
  String? get userName => _userName;
  String? get userPhone => _userPhone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['description'] = _name;
    map['price'] = _price;
    map['stock'] = _stock;

    map['imageUrl'] = _imageUrl;
    map['amount'] = _amount;
    map['total'] = _total;
    map['id'] = _id;
    map['productId'] = _productId;
    map['branchName'] = _branchName;
    map['userName'] = _userName;
    map['userPhone'] = _userPhone;

    return map;
  }
}
