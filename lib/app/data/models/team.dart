
import 'package:ciilaabokk/app/data/models/user.dart';

class Team {
  String? id;
  String? name;
  dynamic user;
  // String? deletedAt;
  // String? createdAt;
  // String? updatedAt;
  //Pivot? pivot;

  Team({
    this.id,
    this.name,
    this.user,
    // this.deletedAt,
    // this.createdAt,
    // this.updatedAt,
    //this.pivot
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      user: json['user'] != null
        ? User.fromJson(json['user'])
        : null
      
      // deletedAt: json['deleted_at'],
      // createdAt: json['created_at'],
      // updatedAt: json['updated_at'],
    );
    //pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  @override
  String toString() {
    return "Id: ${id}, Name: ${name}, User: ${user.toString()}";
  }
}
