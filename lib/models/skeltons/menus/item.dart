class MenuItem {
  String sId, name, img, price, description, cal, cookingPref;
  int orderQuantity;
  bool isCookable;
  double rating;
  MenuItem(
      {this.sId,
      this.name,
      this.description,
      this.cal,
      this.img,
      this.price,
      this.rating = 1.0,
      this.isCookable = true,
      this.cookingPref = "Well Done",
      this.orderQuantity = 1});
}
