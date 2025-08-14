import 'package:ciilaabokk/app/data/services/auth_services.dart';

class Types {
  int? id;
  String? name;
  // String? deletedAt;
  // String? createdAt;
  // String? updatedAt;
  //Pivot? pivot;

  Types({
    this.id,
    this.name,
    // this.deletedAt,
    // this.createdAt,
    // this.updatedAt,
    //this.pivot
  });

  factory Types.fromJson(Map<String, dynamic> json) {
    return Types(
      id: json['id'] as int,
      name: json['name'],
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
    return "Id: ${id}, Name: ${name}";
  }
}
