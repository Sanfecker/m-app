import 'package:Nuvle/models/skeltons/user/userAccount.dart';

class TabModel {
  String id;
  TabModelAttributes attributes;
  Links links;

  TabModel({this.id, this.attributes, this.links});

  TabModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new TabModelAttributes.fromJson(json['attributes'])
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

class TabModelAttributes {
  String id;
  String groupCode;
  bool opened;
  UserAccount user;
  String restaurantId;
  String tableId;
  String createdAt;
  String updatedAt;

  TabModelAttributes(
      {this.id,
      this.groupCode,
      this.opened,
      this.user,
      this.restaurantId,
      this.tableId,
      this.createdAt,
      this.updatedAt});

  TabModelAttributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupCode = json['group_code'];
    opened = json['opened'];
    user = json['user'] != null
        ? new UserAccount(
            attributes: UserAccountAttributes.fromJson(json['user']))
        : null;
    restaurantId = json['restaurant_id'];
    tableId = json['table_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['group_code'] = this.groupCode;
    data['opened'] = this.opened;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['restaurant_id'] = this.restaurantId;
    data['table_id'] = this.tableId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Links {
  String self;
  String invite;

  Links({this.self, this.invite});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'];
    invite = json['invite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['self'] = this.self;
    data['invite'] = this.invite;
    return data;
  }
}
