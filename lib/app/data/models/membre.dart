class Membres {
  int? id;
  String? name;
  String? status;
  String? phoneNumber;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? team_id;

  Membres({
    this.id,
    this.name,
    this.phoneNumber,
    this.team_id,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  Membres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    team_id = json['team_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone_number'] = this.phoneNumber;
    data['name'] = this.name;
    return data;
  }

  @override
  String toString() {
    return "Id: ${id}, Name: ${name}, Phone number: ${phoneNumber}, Team id: ${team_id}, Status: ${status}, DeletedAt: ${deletedAt}, CreatedAt: ${createdAt}, UpdatedAt: ${updatedAt}";
  }
}
