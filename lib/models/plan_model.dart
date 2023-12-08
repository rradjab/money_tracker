import 'package:cloud_firestore/cloud_firestore.dart';

class PlanModel {
  String? id;
  String? name;
  double? cost;
  Timestamp? added;

  PlanModel({this.cost, this.id, this.name});

  PlanModel.fromJson(this.id, Map<String, dynamic> json) {
    name = json['name'];
    cost = json['cost'].toDouble();
    added = json['added'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['cost'] = cost;
    data['name'] = name;
    return data;
  }
}
