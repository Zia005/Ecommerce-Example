class Model {

  late int _id;
  late int proId;
  late String pName;
  late  int pPrice;
  late  int pQuantity;
  late  int tPrice;
  late  String pImg;

  Model(this._id, this.proId, this.pName, this.pPrice, this.pQuantity,
      this.tPrice, this.pImg);

  int get id {
    return _id;
  }
  int get pid =>proId;
  String get productName => pName;
  int get productPrice => pPrice;
  int get productQuantity => pQuantity;
  int get t_price =>tPrice;
  String get productImg => pImg;

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['product_id'] = _id;
    }
    map['name'] = pName;
    map['qty']=pQuantity;
    map['sale_price']=pPrice;
    map['amount']=tPrice;
    map['imagelink']=pImg;

    return map;
  }

  Model.map(dynamic obj){
    this._id=obj['product_id'];
    this.pName=obj['name'];
    this.pQuantity=obj['qty'];
    this.pPrice=obj['price'];
    this.tPrice=obj['amount'];
    this.pImg=obj['imagelink'];
  }

  // Extract a Note object from a Map object
  Model.fromMapObject(Map<String, dynamic> map) {
    this._id = map['product_id'];
    this.pName=map['name'];
    this.pQuantity=map['qty'];
    this.pPrice=map['sale_price'];
    this.tPrice=map['amount'];
    this.pImg=map['imagelink'];
  }


}