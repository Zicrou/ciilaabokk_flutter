import 'package:ciilaabokk/app/data/models/depenses.dart';
import 'package:ciilaabokk/app/data/models/operation.dart';
import 'package:get/get.dart';

class JournalInfo {
  RxList<Operation> operations = <Operation>[].obs;

  RxList<Depenses>? depenses  = <Depenses>[].obs;

  JournalInfo({required this.operations, this.depenses});

  JournalInfo.fromJson(Map<String, dynamic> json) {
    if (json['operations'] != null) {
      operations = operations;
      json['operations'].forEach((v) {
        logger.i("Assignation de $v dans operation");
        operations!.add(new Operation.fromJson(v));
        logger.i("Assignation faite!");

      });
    }
    if (json['depenses'] != null) {
      depenses = depenses;
      json['depenses'].forEach((v) {
        logger.i("Assignation de $v dans dépense");
        depenses!.add(new Depenses.fromJson(v));
        logger.i("Assignation faite!");
      });
    }
  }
  @override
  String toString() {
    // TODO: implement toString
    return "Depenses: $depenses, opération: $operations";
  }
}