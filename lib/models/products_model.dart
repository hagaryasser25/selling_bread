
class Products {
  Products({
    String? id,
    String? name,
    String? imageUrl,
    String? branchName,
    String? description,
    String? price,
    int? amount,
  }) {
    _id = id;
    _name = name;
    _imageUrl = imageUrl;
    _branchName = branchName;
    _description = description;
    _price = price;
    _amount = amount;
  }

  Products.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _imageUrl = json['imageUrl'];
    _branchName = json['branchName'];
    _description = json['description'];
    _price = json['price'];
    _amount = json['amount'];
  }

  String? _id;
  String? _name;
  String? _imageUrl;
  String? _branchName;
  String? _description;
  String? _price;
  int? _amount;

  String? get id => _id;
  String? get name => _name;
  String? get imageUrl => _imageUrl;
  String? get branchName => _branchName;
  String? get description => _description;
  String? get price => _price;
  int? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['imageUrl'] = _imageUrl;
    map['branchName'] = _branchName;
    map['description'] = _description;
    map['price'] = _price;
    map['amount'] = _amount;

    return map;
  }
}