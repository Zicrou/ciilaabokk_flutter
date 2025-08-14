import 'package:ciilaabokk/app/modules/auths/login/login_controller.dart';

class Depenses {
  int? id;
  String? libelle;
  int? montant;
  String? deletedAt;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Depenses({
    this.id,
    this.libelle,
    this.montant,
    this.deletedAt,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  Depenses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    libelle = json['libelle'];
    montant = json['montant'];
    // deletedAt = json['deleted_at'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['libelle'] = this.libelle;
    data['montant'] = this.montant;
    data['user_id'] = this.userId;
    logger.i("Depenses toJson: ${data}");
    return data;
  }

  @override
  String toString() {
    return "Depenses: Id ${id}, Libellé ${libelle}, Montant ${montant}, UserId ${userId}, DeletedAt ${deletedAt}, CreatedAt ${createdAt}, UpdatedAt {$updatedAt}";
  }
}
