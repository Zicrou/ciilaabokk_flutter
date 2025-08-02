class Vente {
  int? id;
  String? designation;
  int? nombre;
  double? prix;
  Null image;
  int? produitId;
  Null deletedAt;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Vente({
    this.id,
    this.designation,
    this.nombre,
    this.prix,
    this.image,
    this.produitId,
    this.deletedAt,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  Vente.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    designation = json['designation'];
    nombre = json['nombre'];
    prix = json['prix'] != null ? (json['prix'] as num).toDouble() : 0.0;
    image = json['image'];
    produitId = json['produit_id'];
    deletedAt = json['deleted_at'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['designation'] = this.designation;
    data['nombre'] = this.nombre;
    data['prix'] = this.prix;
    data['image'] = this.image;
    data['produit_id'] = this.produitId;
    data['deleted_at'] = this.deletedAt;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'Vente{id: $id, designation: $designation, nombre: $nombre, prix: $prix, image: $image, produitId: $produitId, deletedAt: $deletedAt, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
