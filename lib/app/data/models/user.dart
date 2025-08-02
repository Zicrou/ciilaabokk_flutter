class User {
  int? id;
  String? name;
  String? phoneNumber;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.name,
    this.phoneNumber,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  @override
  String toString() {
    return "Id: ${id}, Name: ${name}, Phone number: ${phoneNumber}, DeletedAt: ${deletedAt}, CreatedAt: ${createdAt}, UpdatedAt: ${updatedAt}";
  }
}
