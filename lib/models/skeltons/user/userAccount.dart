import 'package:Nuvle/models/skeltons/user/tab.dart';

class UserAccount {
  String token;
  String id;
  UserAccountAttributes attributes;
  TabModel tab;
  Links links;

  UserAccount({this.token, this.tab, this.id, this.attributes, this.links});

  UserAccount.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
    attributes = json['attributes'] != null
        ? new UserAccountAttributes.fromJson(json['attributes'])
        : null;
    tab = json['tab'] != null ? new TabModel.fromJson(json['tab']) : null;
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['id'] = this.id;
    if (this.attributes != null) {
      data['attributes'] = this.attributes.toJson();
    }
    if (this.tab != null) {
      data['tab'] = this.tab.toJson();
    }
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    return data;
  }
}

class UserAccountAttributes {
  String id, firstname, lastname, name, email, password, rePassword;
  DateTime birthDate, createdAt, updatedAt;

  UserAccountAttributes(
      {this.id,
      this.email,
      this.name,
      this.firstname,
      this.lastname,
      this.password,
      this.rePassword,
      this.birthDate,
      this.createdAt,
      this.updatedAt});

  UserAccountAttributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    if (json['birth_date'] != null) {
      birthDate = DateTime.parse(json['birth_date']);
    }
    if (json['createdAt'] != null) {
      createdAt = DateTime.parse(json['createdAt']);
    }
    if (json['updatedAt'] != null) {
      updatedAt = DateTime.parse(json['updatedAt']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['birth_date'] = this.birthDate?.toString();
    data['createdAt'] = this.createdAt?.toString();
    data['updatedAt'] = this.updatedAt?.toString();
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
