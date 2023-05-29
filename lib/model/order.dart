class OrderInfo {
  int businessId;
  String businessName;
  double totalPrice;
  List<OrderItem> foodList;

  OrderInfo(this.businessId, this.businessName, this.totalPrice, this.foodList);

  Map toJson() {
    Map map = Map();
    map["businessId"] = this.businessId;
    map["businessName"] = this.businessName;
    map["totalPrice"] = this.totalPrice;
    map["foodList"] = this.foodList;
    return map;
  }
}

class OrderItem {
  int foodId;
  String foodName;
  String cover;
  double foodPrice;
  int count;

  OrderItem(this.foodId, this.foodName, this.cover, this.foodPrice, this.count);

  Map toJson() {
    Map map = Map();
    map["foodId"] = this.foodId;
    map["foodName"] = this.foodName;
    map["cover"] = this.cover;
    map["foodPrice"] = this.foodPrice;
    map["count"] = this.count;
    return map;
  }
}
