class MenuData {
  int currentPage;
  bool hasNextPage;
  bool hasPreviousPage;
  int itemsPerPage;
  List<MenuItems> menuItems;
  String menuType;
  int nextPage;
  int numberOfPages;
  int previousPage;
  int totalNumberOfItems;

  MenuData(
      {this.currentPage,
      this.hasNextPage,
      this.hasPreviousPage,
      this.itemsPerPage,
      this.menuItems,
      this.menuType,
      this.nextPage,
      this.numberOfPages,
      this.previousPage,
      this.totalNumberOfItems});

  MenuData.fromJson(Map<String, dynamic> json, [String menuType]) {
    currentPage = json['current_page'];
    hasNextPage = json['has_next_page'];
    hasPreviousPage = json['has_previous_page'];
    itemsPerPage = json['items_per_page'];
    if (json['menu_items'] != null) {
      menuItems = new List<MenuItems>();
      json['menu_items'].forEach((v) {
        menuItems.add(new MenuItems.fromJson(v));
      });
    }
    this.menuType = menuType;
    nextPage = json['next_page'];
    numberOfPages = json['number_of_pages'];
    previousPage = json['previous_page'];
    totalNumberOfItems = json['total_number_of_items'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['has_next_page'] = this.hasNextPage;
    data['has_previous_page'] = this.hasPreviousPage;
    data['items_per_page'] = this.itemsPerPage;
    if (this.menuItems != null) {
      data['menu_items'] = this.menuItems.map((v) => v.toJson()).toList();
    }
    data['next_page'] = this.nextPage;
    data['number_of_pages'] = this.numberOfPages;
    data['previous_page'] = this.previousPage;
    data['total_number_of_items'] = this.totalNumberOfItems;
    return data;
  }
}

class MenuItems {
  int calorieCount;
  String categoryId;
  String categoryName;
  List<String> cookingPreferences;
  String selectedCookingPreference;
  int orderQuantity;
  bool takeAway;
  double rating;
  String currency;
  String description;
  List<String> dietaryRestrictions;
  String imageUrl;
  bool isLive;
  String itemId;
  String itemName;
  List<ItemTags> itemTags;
  String itemType;
  String price;
  String restaurantId;
  String restaurantName;
  List<ServedWith> servedWith;
  List<MenuItems> sides;
  List<MenuItems> selectedSides;
  List<MenuItems> confirmedSides;
  int sidesCount;
  String note;

  MenuItems(
      {this.calorieCount,
      this.categoryId,
      this.categoryName,
      this.cookingPreferences,
      this.selectedCookingPreference,
      this.orderQuantity = 1,
      this.takeAway = false,
      this.currency,
      this.description,
      this.dietaryRestrictions,
      this.imageUrl,
      this.isLive,
      this.rating = 1.0,
      this.itemId,
      this.itemName,
      this.itemTags,
      this.itemType,
      this.price,
      this.restaurantId,
      this.restaurantName,
      this.servedWith,
      this.sides,
      this.selectedSides,
      this.confirmedSides,
      this.sidesCount,
      this.note});

  MenuItems.fromJson(Map<String, dynamic> json) {
    calorieCount = json['calorie_count'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    if (json['cooking_preferences'] != null) {
      cookingPreferences = json['cooking_preferences'].cast<String>();
    }
    currency = json['currency'];
    description = json['description'];
    if (json['dietary_restrictions'] != null) {
      dietaryRestrictions = json['dietary_restrictions'].cast<String>();
    }
    imageUrl = json['image_url'];
    isLive = json['is_live'];
    itemId = json['item_id'];
    itemName = json['item_name'];
    if (json['item_tags'] != null) {
      itemTags = new List<ItemTags>();
      json['item_tags'].forEach((v) {
        itemTags.add(new ItemTags.fromJson(v));
      });
    }
    itemType = json['item_type'];
    price = json['price'];
    restaurantId = json['restaurant_id'];
    restaurantName = json['restaurant_name'];
    if (json['served_with'] != null) {
      servedWith = new List<ServedWith>();
      json['served_with'].forEach((v) {
        servedWith.add(new ServedWith.fromJson(v));
      });
    }
    if (json['sides'] != null) {
      sides = new List<MenuItems>();
      json['sides'].forEach((v) {
        sides.add(new MenuItems.fromJson(v));
      });
    }
    sidesCount = json['sides_count'];
    orderQuantity = 1;
    rating = 1.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['calorie_count'] = this.calorieCount;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['cooking_preferences'] = this.cookingPreferences;
    data['currency'] = this.currency;
    data['description'] = this.description;
    data['dietary_restrictions'] = this.dietaryRestrictions;
    data['image_url'] = this.imageUrl;
    data['is_live'] = this.isLive;
    data['item_id'] = this.itemId;
    data['item_name'] = this.itemName;
    if (this.itemTags != null) {
      data['item_tags'] = this.itemTags.map((v) => v.toJson()).toList();
    }
    data['item_type'] = this.itemType;
    data['price'] = this.price;
    data['restaurant_id'] = this.restaurantId;
    data['restaurant_name'] = this.restaurantName;
    if (this.servedWith != null) {
      data['served_with'] = this.servedWith.map((v) => v.toJson()).toList();
    }
    if (this.sides != null) {
      data['sides'] = this.sides.map((v) => v.toJson()).toList();
    }
    data['sides_count'] = this.sidesCount;
    return data;
  }
}

class ItemTags {
  String tagId;
  String tagName;

  ItemTags({this.tagId, this.tagName});

  ItemTags.fromJson(Map<String, dynamic> json) {
    tagId = json['tag_id'];
    tagName = json['tag_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag_id'] = this.tagId;
    data['tag_name'] = this.tagName;
    return data;
  }
}

class ServedWith {
  String servedWithId;
  String servedWithName;

  ServedWith({this.servedWithId, this.servedWithName});

  ServedWith.fromJson(Map<String, dynamic> json) {
    servedWithId = json['served_with_id'];
    servedWithName = json['served_with_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['served_with_id'] = this.servedWithId;
    data['served_with_name'] = this.servedWithName;
    return data;
  }
}
