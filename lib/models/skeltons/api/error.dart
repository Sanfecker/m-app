class Error {
  String title;
  String detail;
  String field;

  Error({this.title, this.detail, this.field});

  Error.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    detail = json['detail'];
    field = json['field'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['detail'] = this.detail;
    data['field'] = this.field;
    return data;
  }
}