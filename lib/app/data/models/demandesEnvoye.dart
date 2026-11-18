class DemandesEnvoye {
  String? id;
  String? teamId;
  String? invitedBy;
  String? userId;
  String? status;
  Null? expiresAt;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  DemandesEnvoye(
      {this.id,
      this.teamId,
      this.invitedBy,
      this.userId,
      this.status,
      this.expiresAt,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  DemandesEnvoye.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamId = json['team_id'];
    invitedBy = json['invited_by'];
    userId = json['user_id'];
    status = json['status'];
    expiresAt = json['expires_at'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['team_id'] = this.teamId;
    data['invited_by'] = this.invitedBy;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['expires_at'] = this.expiresAt;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}