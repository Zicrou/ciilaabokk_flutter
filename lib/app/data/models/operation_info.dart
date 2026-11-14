import 'package:ciilaabokk/app/data/models/operation.dart';
import 'package:decimal/decimal.dart';
import 'package:get/get.dart';

class OperationInfo {
  RxList<Operation> operations = <Operation>[].obs;
  // RxList<
  List<dynamic>? input;
  Decimal? totalOfTheDay;
  Decimal? totalVenteOfTheDay;
  Decimal? totalReparationOfTheDay;
  Decimal? depenseTotal;
  String? status;

  OperationInfo({
    required this.operations,
    this.input,
    this.totalOfTheDay,
    this.totalVenteOfTheDay,
    this.totalReparationOfTheDay,
    this.depenseTotal,
    this.status,
  });

  OperationInfo.fromJson(Map<String, dynamic> json) {
    totalOfTheDay = Decimal.tryParse(json['totalOfTheDay']?.toString() ?? '');
    totalVenteOfTheDay = Decimal.tryParse(
      json['totalVenteOfTheDay']?.toString() ?? '',
    );
    totalReparationOfTheDay = Decimal.tryParse(
      json['totalReparationOfTheDay']?.toString() ?? '',
    );
    depenseTotal = Decimal.tryParse(json['depenseTotal']?.toString() ?? '');
    status = json['status'];
    if (json['operation'] != null) {
      operations = operations;
      json['operations'].forEach((o) {
        operations.add(new Operation.fromJson(o));
        json['types'] = o['types']['name']; // Ensure types is handled correctly
      });
    }
    if (json['input'] != null) {
      input = <dynamic>[];
      json['input'].forEach((o) {
        input!.add(o);
      });
    }
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //if (this.operations != null) {
    data['operations'] = this.operations.map((v) => v.toJson()).toList();
    //}
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
    return 'OperationInfo{operations: $operations, input: $input, totalOfTheDay: $totalOfTheDay, totalVenteOfTheDay: $totalVenteOfTheDay, totalReparationOfTheDay: $totalReparationOfTheDay, depenseTotal: $depenseTotal, status: $status}';
  }
}
