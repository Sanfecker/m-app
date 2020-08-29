class ScanResponse {
  String tableId;
  String code;
  String restaurantId;

  ScanResponse({this.tableId, this.code, this.restaurantId});

  ScanResponse.fromJson(Map<String, dynamic> json) {
    tableId = json['table_id'];
    restaurantId = json['restaurant_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['table_id'] = this.tableId;
    data['restaurant_id'] = this.restaurantId;
    return data;
  }
}