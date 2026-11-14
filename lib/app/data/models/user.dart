import 'package:ciilaabokk/app/data/models/team.dart';

class User {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? role;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? team_id;
  dynamic team;

  User({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.role,
    this.team_id,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.team,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone'];
    role = json['role'];
    team_id = json['team_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    team = json['team'] != null ? new Team.fromJson(json['team']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  @override
  String toString() {
    return "Id: ${id}, Name: ${name}, Email: $email, Phone number: ${phoneNumber}, Team id: ${team_id}, DeletedAt: ${deletedAt}, CreatedAt: ${createdAt}, UpdatedAt: ${updatedAt}, Team ${team.toString()}";
  }
}
