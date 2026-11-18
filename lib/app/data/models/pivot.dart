class Pivot {
  String? teamId;
  String? userId;
  String? role;
  String? createdAt;
  String? updatedAt;

  Pivot({this.teamId, this.userId, this.role, this.createdAt, this.updatedAt});

  Pivot.fromJson(Map<String, dynamic> json) {
    teamId = json['team_id'];
    userId = json['user_id'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['team_id'] = this.teamId;
    data['user_id'] = this.userId;
    data['role'] = this.role;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
  @override
  String toString() {
    // TODO: implement toString
    return "Team id: $teamId, user id: $userId, role: $role";
  }
}