import 'package:ciilaabokk/app/data/models/pivot.dart';

class Membres {
  String? id;
  String? name;
  String? status;
  String? phoneNumber;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? team_id;
  String? user_email_or_phone;
  Pivot? pivot;
  Membres({
    this.id,
    this.name,
    this.phoneNumber,
    this.team_id,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.user_email_or_phone,
    this.pivot,
  });

  Membres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phone'];
    team_id = json['team_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_email_or_phone'] = this.user_email_or_phone;
    return data;
  }

  @override
  String toString() {
    return "Id: ${id}, Name: ${name}, Phone number: ${phoneNumber}, Team id: ${team_id}, Pivot: ${pivot.toString()}, DeletedAt: ${deletedAt}, CreatedAt: ${createdAt}, UpdatedAt: ${updatedAt}";
  }
}
