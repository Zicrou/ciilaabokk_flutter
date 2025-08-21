class Produit {
  int? id;
  String? designation;
  int? nombre;
  int? montant;
  String? image;
  int? userId;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Produit({
    this.id,
    this.designation,
    this.nombre,
    this.montant,
    this.image,
    this.userId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  Produit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    designation = json['designation'];
    nombre = json['nombre'];
    montant = json['montant'];
    image = json['image'];
    userId = json['user_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['designation'] = this.designation;
    data['nombre'] = this.nombre;
    data['montant'] = this.montant;
    data['image'] = this.image;
    data['user_id'] = this.userId;
    return data;
  }
}
