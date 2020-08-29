class OrderModel {
  String id;
  OrderAttributes attributes;
  Links links;

  OrderModel({this.id, this.attributes, this.links});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new OrderAttributes.fromJson(json['attributes'])
        : null;
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.attributes != null) {
      data['attributes'] = this.attributes.toJson();
    }
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    return data;
  }
}

class OrderAttributes {
  String user;
  String tab;
  String restaurantId;
  String itemId;
  String itemType;
  List<String> sideDishesIds;
  List<String> cookingPreferences;
  String note;
  String createdAt;
  String updatedAt;

  OrderAttributes(
      {this.user,
      this.tab,
      this.restaurantId,
      this.itemId,
      this.itemType,
      this.sideDishesIds,
      this.cookingPreferences,
      this.note,
      this.createdAt,
      this.updatedAt});

  OrderAttributes.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    tab = json['tab'];
    restaurantId = json['restaurant_id'];
    itemId = json['item_id'];
    itemType = json['item_type'];
    if (json['side_dishes_ids'] != null) {
      sideDishesIds = json['side_dishes_ids'].cast<String>();
    }
    if (json['cooking_preferences'] != null) {
      cookingPreferences = json['cooking_preferences'].cast<String>();
    }
    note = json['note'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['tab'] = this.tab;
    data['restaurant_id'] = this.restaurantId;
    data['item_id'] = this.itemId;
    data['item_type'] = this.itemType;
    if (this.sideDishesIds != null) {
      data['side_dishes_ids'] = this.sideDishesIds;
    }
    if (this.cookingPreferences != null) {
      data['cooking_preferences'] = this.cookingPreferences;
    }
    data['note'] = this.note;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Links {
  String self;

  Links({this.self});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['self'] = this.self;
    return data;
  }
}
