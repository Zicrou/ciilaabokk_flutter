import 'package:ciilaabokk/app/data/models/vente.dart';

class VenteInfo {
  List<Vente>? ventes;
  List<dynamic>? input;
  int? totalOfTheDay;
  int? totalVenteOfTheDay;
  int? totalReparationOfTheDay;
  int? depenseTotal;
  String? status;

  VenteInfo({
    this.ventes,
    this.input,
    this.totalOfTheDay,
    this.totalVenteOfTheDay,
    this.totalReparationOfTheDay,
    this.depenseTotal,
    this.status,
  });

  VenteInfo.fromJson(Map<String, dynamic> json) {
    if (json['ventes'] != null) {
      ventes = <Vente>[];
      json['ventes'].forEach((v) {
        ventes!.add(new Vente.fromJson(v));
      });
    }
    if (json['input'] != null) {
      input = <dynamic>[];
      json['input'].forEach((v) {
        input!.add(v);
      });
    }
    totalOfTheDay = json['totalOfTheDay'];
    totalVenteOfTheDay = json['totalVenteOfTheDay'];
    totalReparationOfTheDay = json['totalReparationOfTheDay'];
    depenseTotal = json['depenseTotal'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ventes != null) {
      data['ventes'] = this.ventes!.map((v) => v.toJson()).toList();
    }
    if (this.input != null) {
      data['input'] = this.input;
    }
    data['totalOfTheDay'] = this.totalOfTheDay;
    data['totalVenteOfTheDay'] = this.totalVenteOfTheDay;
    data['totalReparationOfTheDay'] = this.totalReparationOfTheDay;
    data['depenseTotal'] = this.depenseTotal;
    data['status'] = this.status;
    return data;
  }

  @override
  String toString() {
    return 'VenteInfo{ventes: $ventes, input: $input, totalOfTheDay: $totalOfTheDay, totalVenteOfTheDay: $totalVenteOfTheDay, totalReparationOfTheDay: $totalReparationOfTheDay, depenseTotal: $depenseTotal, status: $status}';
  }
}
