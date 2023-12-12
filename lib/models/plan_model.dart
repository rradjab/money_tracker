import 'package:cloud_firestore/cloud_firestore.dart';

class PlanModel {
  String? id;
  String? name;
  String? color;
  double? cost;
  Timestamp? added;

  PlanModel({this.cost, this.id, this.name, this.color});

  PlanModel.fromJson(this.id, Map<String, dynamic> json) {
    name = json['name'];
    color = json['color'];
    cost = json['cost'].toDouble();
    added = json['added'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['cost'] = cost;
    data['color'] = color;
    data['name'] = name;
    return data;
  }
}
