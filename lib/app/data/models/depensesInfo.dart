import 'package:ciilaabokk/app/data/models/depenses.dart';
import 'package:ciilaabokk/app/data/providers/api_providers.dart';
import 'package:decimal/decimal.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

final logger = Logger();
class DepensesInfo {
  RxList<Depenses> depenses = <Depenses>[].obs;
  String? status;
  Decimal? totalOfTheDay;

  DepensesInfo({required this.depenses, this.status});

  DepensesInfo.fromJson(Map<String, dynamic> json) {
    logger.i("DepensesInfo fromJson: ${json['depenses']}");
    if (json['depenses'] != null) {
      depenses = depenses;
      json['depenses'].forEach((v) {
        depenses.add(new Depenses.fromJson(v));
      });
    }
    status = json['status'];
    totalOfTheDay = Decimal.tryParse(json['totalDepense'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.depenses != null) {
      data['depenses'] = this.depenses!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Depense Info: Depense ${depenses}, Statut: ${status}, Dépense total: ${totalOfTheDay}";
  }
}
